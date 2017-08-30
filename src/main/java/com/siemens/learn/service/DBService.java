package com.siemens.learn.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
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
	
	public String getPassword(String gid)
	{
        GetItemSpec spec = new GetItemSpec().withPrimaryKey("GID", gid);

        try 
        {
            System.out.println("Attempting to read the item...");
            Item outcome = table.getItem(spec);
            System.out.println("GetItem succeeded: ");
            return outcome.getString("password");
        }
        catch (Exception e) 
        {
            System.err.println("Unable to read item: " + gid);
            System.err.println(e.getMessage());
        }
        return null;
    }

	public List<Map<String, String>> getTargets(String gid, String quarter)
	{
		List<Map<String, String>> targets = new ArrayList<>();
		GetItemSpec spec = new GetItemSpec().withPrimaryKey("GID", gid);
		
		try 
		{
			System.out.println("Attempting to read the item...");
			Item outcome = table.getItem(spec);
			System.out.println("GetItem succeeded: ");
			List<Map<String, String>> list = outcome.getList("targets");
			for (Map<String, String> map : list) 
			{
				for (Entry<String, String> entry : map.entrySet()) 
				{
					if(entry.getKey().equals("quarter") && entry.getValue().equals(quarter))
						targets.add(map);
				}
			}
		}
		catch (Exception e) 
		{
			System.err.println("Unable to read item: " + gid);
			System.err.println(e.getMessage());
		}
		return targets;
	}
	
	public void submit(String gid, List<Map<String, String>> targetsToBeAddded, String risk, String quarter)
	{
		Map<String, Object> expressionAttributeValues = new HashMap<>();
		expressionAttributeValues.put(":val1", targetsToBeAddded);
		expressionAttributeValues.put(":val2", risk);
		
		String updateExpr = "";
		if(quarter.equals("Quarter 1"))
			updateExpr = "set targets = :val1, q1risk = :val2";
		else if(quarter.equals("Quarter 2"))
			updateExpr = "set targets = :val1, q2risk = :val2";
		else if(quarter.equals("Quarter 3"))
			updateExpr = "set targets = :val1, q3risk = :val2";
		else if(quarter.equals("Quarter 4"))
			updateExpr = "set targets = :val1, q4risk = :val2";
		
		UpdateItemSpec updateItemSpec = new UpdateItemSpec().withPrimaryKey("GID", gid)
	            .withUpdateExpression(updateExpr)
	            .withValueMap(expressionAttributeValues)
	            .withReturnValues(ReturnValue.UPDATED_NEW);
        try 
        {
            System.out.println("Updating the item...");
            UpdateItemOutcome outcome = table.updateItem(updateItemSpec);
            System.out.println("UpdateItem succeeded:\n" + outcome.getItem().toJSONPretty());

        }
        catch (Exception e) 
        {
            System.err.println("Unable to update item: " + gid);
            System.err.println(e.getMessage());
        }
	}
	
	public List<List<String>> getRiskForGroup(String groupName)
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

        try 
        {
            ItemCollection<ScanOutcome> items = table.scan(scanSpec);

            Iterator<Item> iter = items.iterator();
            while (iter.hasNext()) 
            {
                Item item = iter.next();
                q1Risk.add(item.getString("q1risk"));
                q2Risk.add(item.getString("q2risk"));
                q3Risk.add(item.getString("q3risk"));
                q4Risk.add(item.getString("q4risk"));
            }
        }
        catch (Exception e) 
        {
            System.err.println("Unable to scan the table:");
            System.err.println(e.getMessage());
        }
        allRisks.add(q1Risk);
        allRisks.add(q2Risk);
        allRisks.add(q3Risk);
        allRisks.add(q4Risk);
		return allRisks;
	}
	
	public String getRole(String gid)
	{
		GetItemSpec spec = new GetItemSpec().withPrimaryKey("GID", gid);

        try 
        {
            System.out.println("Attempting to read the item...");
            Item outcome = table.getItem(spec);
            System.out.println("GetItem succeeded: ");
            return outcome.getString("role");
        }
        catch (Exception e) 
        {
            System.err.println("Unable to read item: " + gid);
            System.err.println(e.getMessage());
        }
        return null;
	}
	
	public List<String> getGroups()
	{
	    return null;
	}
	
	public List<String> getUsers(String grp)
    {
        return null;
    }
	
	public static void main(String[] args) 
	{
//		List<Target> targets = new ArrayList<>();
//		Target target = new Target();
//		target.setTargetName("T2");
//		target.setCategory("C2");
//		target.setCompletionPercent("16");
//		target.setQuarter("Q2");
//		targets.add(target);
//		dbService.submit("z0024dzv", targets, "100");
		
		DBService dbService = new DBService();
		List<Map<String, String>> targets2 = dbService.getTargets("z003cv8z", "Quarter 1");
		for (Map<String, String> map : targets2) 
		{
			for (Entry<String, String> entry : map.entrySet()) 
			{
				System.out.println(entry.getKey() + ": " + entry.getValue());
			}
		}
		
	}
}
