package com.siemens.learn.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder;
import com.amazonaws.services.dynamodbv2.document.DynamoDB;
import com.amazonaws.services.dynamodbv2.document.Item;
import com.amazonaws.services.dynamodbv2.document.Table;
import com.amazonaws.services.dynamodbv2.model.AttributeDefinition;
import com.amazonaws.services.dynamodbv2.model.KeySchemaElement;
import com.amazonaws.services.dynamodbv2.model.KeyType;
import com.amazonaws.services.dynamodbv2.model.ProvisionedThroughput;
import com.amazonaws.services.dynamodbv2.model.ScalarAttributeType;
import com.fasterxml.jackson.core.JsonParseException;

public class Dynamo 
{
	public static void main(String[] args) throws JsonParseException, IOException 
	{
		new Dynamo().delete("Users");
		new Dynamo().create("Users", "GID");
		new Dynamo().insert("Users");
	}
	
	private void create(String tableName, String partitionKey)
	{
		AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard()
				.withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("http://localhost:8000", "us-west-2"))
	            .build();

        DynamoDB dynamoDB = new DynamoDB(client);
        try 
        {
            System.out.println("Attempting to create table; please wait...");
            Table table = dynamoDB.createTable(tableName, Arrays.asList(new KeySchemaElement(partitionKey, KeyType.HASH)),
                Arrays.asList(new AttributeDefinition(partitionKey, ScalarAttributeType.S)), new ProvisionedThroughput(10L, 10L));
            table.waitForActive();
            System.out.println("Success.  Table status: " + table.getDescription().getTableStatus());
        }
        catch (Exception e)
        {
            System.err.println("Unable to create table: ");
            System.err.println(e.getMessage());
        }
    }

	private void insert(String tableName) throws JsonParseException, IOException
	{
		AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard()
				.withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("http://localhost:8000", "us-west-2"))
	            .build();

        DynamoDB dynamoDB = new DynamoDB(client);
        Table table = dynamoDB.getTable(tableName);
        try 
        {
//        	List<Map<String, String>> targets1 = addTargetsForFirst();
//        	List<Map<String, String>> targets2 = addTargetsForSecond();
        	List<Map<String, String>> targets1 = new ArrayList<>();
        	List<Map<String, String>> targets2 = new ArrayList<>();

            table.putItem(new Item().withPrimaryKey("GID", "z0024dzv")
            		.withString("name", "Suyash")
            		.withString("password", "$2a$10$2YRbg8zznLOLrKaLotq56uXCp1M8SS3rQLy3UYDOGF8UrJ9KDicHS")
            		.withString("pwdChanged", "false")
            		.withString("role", "manager")
            		.withString("group", "R8")
            		.withString("q1risk", "NaN")
            		.withString("q2risk", "NaN")
            		.withString("q3risk", "NaN")
            		.withString("q4risk", "NaN")
            		.withList("q1targets", targets1)
		            .withList("q2targets", targets1)
		            .withList("q3targets", targets1)
		            .withList("q4targets", targets1));
            System.out.println("First PutItem succeeded: ");

            table.putItem(new Item().withPrimaryKey("GID", "z003cv8z")
            		.withString("name", "KC")
            		.withString("password", "$2a$10$m7xN4LloEj4dMbWFCj.lteLTbCn4D8hFJO0cW4SP0RsbQgdUs3zt.")
            		.withString("pwdChanged", "true")
            		.withString("role", "user")
            		.withString("group", "R8")
            		.withString("q1risk", "NaN")
            		.withString("q2risk", "NaN")
            		.withString("q3risk", "NaN")
            		.withString("q4risk", "NaN")
            		.withList("q1targets", targets2)
            		.withList("q2targets", targets2)
            		.withList("q3targets", targets2)
            		.withList("q4targets", targets2));
            System.out.println("Second PutItem succeeded: ");
        }
        catch (Exception e) 
        {
            System.err.println("Unable to add movie: ");
            System.err.println(e.getMessage());
        }
    }

//	private List<Map<String, String>> addTargetsForFirst() 
//	{
//		List<Map<String, String>> targets1 = new ArrayList<>();
//		Map<String, String> target1 = createTarget("t1", "c1", "l1", "0", "Quarte1");
//		targets1.add(target1);
//
//		Map<String, String> target2 = createTarget("t2", "c2", "l2", "0", "Q2");
//		targets1.add(target2);
//		return targets1;
//	}
//
//	private List<Map<String, String>> addTargetsForSecond() 
//	{
//		List<Map<String, String>> targets2 = new ArrayList<>();
//		Map<String, String> target3 = createTarget("t3", "c3", "l3", "0", "Q3");
//		targets2.add(target3);
//		
//		Map<String, String> target4 = createTarget("t4", "c4", "l3", "0", "Q3");
//		targets2.add(target4);
//		return targets2;
//	}

//	private Map<String, String> createTarget(String name, String cat, String level, String comp, String quart) 
//	{
//		Map<String, String> target1 = new HashMap<>();
//		target1.put("name", name);
//		target1.put("category", cat);
//		target1.put("level", level);
//		target1.put("completed", comp);
//		target1.put("quarter", quart);
//		return target1;
//	}
	
	private void delete(String tableName)
	{
		AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard()
            .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("http://localhost:8000", "us-west-2"))
            .build();

        DynamoDB dynamoDB = new DynamoDB(client);
        Table table = dynamoDB.getTable(tableName);
        try 
        {
            System.out.println("Attempting to delete table; please wait...");
            table.delete();
            table.waitForDelete();
            System.out.print("Success.");
        }
        catch (Exception e) 
        {
            System.err.println("Unable to delete table: ");
            System.err.println(e.getMessage());
        }
    }
}