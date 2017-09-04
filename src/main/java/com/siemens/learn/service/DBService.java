package com.siemens.learn.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;
import java.util.Map.Entry;

import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder;
import com.amazonaws.services.dynamodbv2.document.DynamoDB;
import com.amazonaws.services.dynamodbv2.document.Item;
import com.amazonaws.services.dynamodbv2.document.ItemCollection;
import com.amazonaws.services.dynamodbv2.document.ScanOutcome;
import com.amazonaws.services.dynamodbv2.document.Table;
import com.amazonaws.services.dynamodbv2.document.UpdateItemOutcome;
import com.amazonaws.services.dynamodbv2.document.spec.GetItemSpec;
import com.amazonaws.services.dynamodbv2.document.spec.ScanSpec;
import com.amazonaws.services.dynamodbv2.document.spec.UpdateItemSpec;
import com.amazonaws.services.dynamodbv2.document.utils.NameMap;
import com.amazonaws.services.dynamodbv2.document.utils.ValueMap;
import com.amazonaws.services.dynamodbv2.model.AmazonDynamoDBException;
import com.amazonaws.services.dynamodbv2.model.ReturnValue;

public class DBService 
{
	private static final String USERS = "Users";
	private Table table;
	
	public DBService()
	{
		AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard()
				.withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("http://localhost:8000", "us-west-2"))
				.build();
		
		DynamoDB dynamoDB = new DynamoDB(client);
		table = dynamoDB.getTable(USERS);
	}
	
	public String getPassword(String gid) throws Exception
	{
        GetItemSpec spec = new GetItemSpec().withPrimaryKey("GID", gid);

        System.out.println("Attempting to read the item...");
        Item outcome = table.getItem(spec);
        System.out.println("GetItem succeeded: ");
        if(outcome != null)
        	return outcome.getString("password");
        else
        	return "";
    }
	
	public String getName(String gid) throws Exception
	{
        GetItemSpec spec = new GetItemSpec().withPrimaryKey("GID", gid);

        System.out.println("Attempting to read the item...");
        Item outcome = table.getItem(spec);
        System.out.println("GetItem succeeded: ");
        return outcome.getString("name");
    }
	
	public List<String> getUsersInGroup(String groupName)
	{
		List<String> users = new ArrayList<>();
        ScanSpec scanSpec = new ScanSpec().withProjectionExpression("#gr, GID").withFilterExpression("#gr = :gname").withNameMap(new NameMap().with("#gr", "group"))
	            .withValueMap(new ValueMap().withString(":gname", groupName));

        System.out.println("Attempting to read the item...");
        ItemCollection<ScanOutcome> items = table.scan(scanSpec);
        Iterator<Item> iter = items.iterator();
        while (iter.hasNext()) 
        {
            Item item = iter.next();
            users.add(item.getString("GID"));
        }
        System.out.println("GetItem succeeded: ");
        return users;
    
	}

	public List<Map<String, String>> getTargets(String gid, String quarter) throws Exception
	{
		int year = Calendar.getInstance().get(Calendar.YEAR);
		int month = Calendar.getInstance().get(Calendar.MONTH);
		
		if("Quarter 1".equals(quarter) && month > 1)
			year--;
		
		GetItemSpec spec = new GetItemSpec().withPrimaryKey("GID", gid);
		List<Map<String, String>> list = new ArrayList<>();
		
		System.out.println("Attempting to read the item...");
		Item outcome = table.getItem(spec);
		System.out.println("GetItem succeeded: ");
		if(quarter.equals("Quarter 1"))
			list = outcome.getList("q1targets");
		else if(quarter.equals("Quarter 2"))
			list = outcome.getList("q2targets");
		else if(quarter.equals("Quarter 3"))
			list = outcome.getList("q3targets");
		else
			list = outcome.getList("q4targets");

		ListIterator<Map<String, String>> listIterator = list.listIterator();
		while(listIterator.hasNext())
		{
			Map<String, String> next = listIterator.next();
			for (Entry<String, String> entry : next.entrySet()) 
			{
				if("year".equals(entry.getKey()) && year != Integer.parseInt(entry.getValue()))
				{
					listIterator.remove();
					break;
				}
			}
		}
		
		return list;
	}

	public String getRiskForQuarter(String gid, String quarter) throws Exception
	{
		GetItemSpec spec = new GetItemSpec().withPrimaryKey("GID", gid);
		String risk = "";
		System.out.println("Attempting to read the item...");
		Item outcome = table.getItem(spec);
		System.out.println("GetItem succeeded: ");
		if(quarter.equals("Quarter 1"))
			risk = outcome.getString("q1risk");
		else if(quarter.equals("Quarter 2"))
			risk = outcome.getString("q2risk");
		else if(quarter.equals("Quarter 3"))
			risk = outcome.getString("q3risk");
		else
			risk = outcome.getString("q4risk");
		return risk;
	}
	
	public void updateTargets(String gid, List<Map<String, String>> targetsToBeAddded, String risk, String quarter) throws Exception
	{
		Map<String, Object> expressionAttributeValues = new HashMap<>();
		expressionAttributeValues.put(":val1", targetsToBeAddded);
		expressionAttributeValues.put(":val2", risk);
		
		String updateExpr = "";
		if(quarter.equals("Quarter 1"))
			updateExpr = "set q1targets = :val1, q1risk = :val2";
		else if(quarter.equals("Quarter 2"))
			updateExpr = "set q2targets = :val1, q2risk = :val2";
		else if(quarter.equals("Quarter 3"))
			updateExpr = "set q3targets = :val1, q3risk = :val2";
		else if(quarter.equals("Quarter 4"))
			updateExpr = "set q4targets = :val1, q4risk = :val2";
		
		UpdateItemSpec updateItemSpec = new UpdateItemSpec().withPrimaryKey("GID", gid)
	            .withUpdateExpression(updateExpr)
	            .withValueMap(expressionAttributeValues)
	            .withReturnValues(ReturnValue.UPDATED_NEW);
        System.out.println("Updating the item...");
        UpdateItemOutcome outcome = table.updateItem(updateItemSpec);
        System.out.println("UpdateItem succeeded:\n" + outcome.getItem().toJSONPretty());
	}
	
	public List<List<String>> getRiskForGroup(String groupName) throws Exception
	{
		List<List<String>> allRisks = new ArrayList<>();
		List<String> q1Risk = new ArrayList<>();
		List<String> q2Risk = new ArrayList<>();
		List<String> q3Risk = new ArrayList<>();
		List<String> q4Risk = new ArrayList<>();
		
		ScanSpec scanSpec;
		if(!groupName.equals("*"))
			scanSpec = new ScanSpec().withProjectionExpression("#gr, q1risk, q2risk, q3risk, q4risk")
	            .withFilterExpression("#gr = :gname").withNameMap(new NameMap().with("#gr", "group"))
	            .withValueMap(new ValueMap().withString(":gname", groupName));
		else
			scanSpec = new ScanSpec().withProjectionExpression("q1risk, q2risk, q3risk, q4risk");

        ItemCollection<ScanOutcome> items = table.scan(scanSpec);

        Iterator<Item> iter = items.iterator();
        while (iter.hasNext()) 
        {
            Item item = iter.next();
            String q1RiskDb = item.getString("q1risk");
            if(!q1RiskDb.equals("NaN"))
            	q1Risk.add(q1RiskDb);
            String q2RiskDb = item.getString("q2risk");
            if(!q2RiskDb.equals("NaN"))
            	q2Risk.add(q2RiskDb);
            String q3RiskDb = item.getString("q3risk");
            if(!q3RiskDb.equals("NaN"))
            	q3Risk.add(q3RiskDb);
            String q4RiskDb = item.getString("q4risk");
            if(!q4RiskDb.equals("NaN"))
            	q4Risk.add(q4RiskDb);
        }
        
        allRisks.add(q1Risk);
        allRisks.add(q2Risk);
        allRisks.add(q3Risk);
        allRisks.add(q4Risk);
		return allRisks;
	}
	
	public List<String> getRiskForGroupAndQuarter(String groupName, String quarter) throws Exception
	{
		List<String> quarterRisk = new ArrayList<>();
		
		ScanSpec scanSpec;
		if(!groupName.equals("*"))
			scanSpec = new ScanSpec().withProjectionExpression("#gr, q1risk, q2risk, q3risk, q4risk")
	            .withFilterExpression("#gr = :gname").withNameMap(new NameMap().with("#gr", "group"))
	            .withValueMap(new ValueMap().withString(":gname", groupName));
		else
			scanSpec = new ScanSpec().withProjectionExpression("q1risk, q2risk, q3risk, q4risk");

        ItemCollection<ScanOutcome> items = table.scan(scanSpec);

        Iterator<Item> iter = items.iterator();
        while (iter.hasNext()) 
        {
            Item item = iter.next();
            if("Q1".equals(quarter))
            {
	            String q1RiskDb = item.getString("q1risk");
	            if(!q1RiskDb.equals("NaN"))
	            	quarterRisk.add(q1RiskDb);
            }
            else if("Q2".equals(quarter))
            {
	            String q2RiskDb = item.getString("q2risk");
	            if(!q2RiskDb.equals("NaN"))
	            	quarterRisk.add(q2RiskDb);
            }
            else if("Q3".equals(quarter))
            {
	            String q3RiskDb = item.getString("q3risk");
	            if(!q3RiskDb.equals("NaN"))
	            	quarterRisk.add(q3RiskDb);
            }
            else
            {
	            String q4RiskDb = item.getString("q4risk");
	            if(!q4RiskDb.equals("NaN"))
	            	quarterRisk.add(q4RiskDb);
            }
        }
        
		return quarterRisk;
	}
	
	public String getRole(String gid) throws Exception
	{
		GetItemSpec spec = new GetItemSpec().withPrimaryKey("GID", gid);

        System.out.println("Attempting to read the item...");
        Item outcome = table.getItem(spec);
        System.out.println("GetItem succeeded: ");
        return outcome.getString("role");
	}
	
	public String getPasswordChanged(String gid) throws Exception
	{
		GetItemSpec spec = new GetItemSpec().withPrimaryKey("GID", gid);

        System.out.println("Attempting to read the item...");
        Item outcome = table.getItem(spec);
        System.out.println("GetItem succeeded: ");
        return outcome.getString("pwdChanged");
	}

	public void updatePassword(String gid, String encodedPassword) throws AmazonDynamoDBException
	{
		String updateExpr = "set upassword = :val1, pwdChanged = :val2";
		Map<String, Object> expressionAttributeValues = new HashMap<>();
		expressionAttributeValues.put(":val1", encodedPassword);
		expressionAttributeValues.put(":val2", "true");
		UpdateItemSpec updateItemSpec = new UpdateItemSpec().withPrimaryKey("GID", gid)
	            .withUpdateExpression(updateExpr)
	            .withValueMap(expressionAttributeValues)
	            .withReturnValues(ReturnValue.UPDATED_NEW);
        System.out.println("Updating the item...");
        UpdateItemOutcome outcome = table.updateItem(updateItemSpec);
        System.out.println("UpdateItem succeeded:\n" + outcome.getItem().toJSONPretty());
		
	}
	
	public static void main(String[] args) throws Exception 
	{
		DBService dbService = new DBService();
		List<Map<String, String>> targetsToBeUpdated = new ArrayList<>();
		
		Map<String, String> targetDetails = new HashMap<>();
		targetDetails.put("name", "T1");
		targetDetails.put("category", "C1");
		targetDetails.put("level", "L1");
		targetDetails.put("completed", "16");
		targetDetails.put("year", "2018");
		targetsToBeUpdated.add(targetDetails);
			
		dbService.updateTargets("z0024dzv", targetsToBeUpdated, "100", "Quarter 2");
		
//		dbService.update("z003cv8z", new ArrayList<>(), "0", "Quarter 1");
//		dbService.updatePassword("z0024dzv", "s");
		List<Map<String, String>> targets2 = dbService.getTargets("z0024dzv", "Quarter 1");
		for (Map<String, String> map : targets2) 
		{
			for (Entry<String, String> entry : map.entrySet()) 
			{
				System.out.println(entry.getKey() + ": " + entry.getValue());
			}
		}
		
		System.out.println(dbService.getUsersInGroup("R8"));
		
	}
}
