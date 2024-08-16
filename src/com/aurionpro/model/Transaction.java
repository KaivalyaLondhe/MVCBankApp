package com.aurionpro.model;

import java.sql.Timestamp;

public class Transaction {

	  	private int transactionId;
	    private long senderAccountNumber;
	    private long receiverAccountNumber;
	    private String transactionType;
	    private double amount;
	    private Timestamp transactionDate;
	    private String description;
		public int getTransactionId() {
			return transactionId;
		}
		public void setTransactionId(int transactionId) {
			this.transactionId = transactionId;
		}
		public long getSenderAccountNumber() {
			return senderAccountNumber;
		}
		public void setSenderAccountNumber(long senderAccountNumber) {
			this.senderAccountNumber = senderAccountNumber;
		}
		public long getReceiverAccountNumber() {
			return receiverAccountNumber;
		}
		public void setReceiverAccountNumber(long receiverAccountNumber) {
			this.receiverAccountNumber = receiverAccountNumber;
		}
		public String getTransactionType() {
			return transactionType;
		}
		public void setTransactionType(String transactionType) {
			this.transactionType = transactionType;
		}
		public double getAmount() {
			return amount;
		}
		public void setAmount(double amount) {
			this.amount = amount;
		}
		public Timestamp getTransactionDate() {
			return transactionDate;
		}
		public void setTransactionDate(Timestamp transactionDate) {
			this.transactionDate = transactionDate;
		}
		public String getDescription() {
			return description;
		}
		public void setDescription(String description) {
			this.description = description;
		}
	    
	    
	
}
