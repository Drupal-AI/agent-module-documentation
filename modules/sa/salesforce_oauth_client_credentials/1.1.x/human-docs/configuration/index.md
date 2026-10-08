# Configuration

This module has no settings form of its own — it adds a provider type to the
Salesforce Suite's authorization screen, and you configure it there.

## Before you start

In Salesforce, create (or identify) a **connected app** set up for the OAuth
client-credentials flow, and note its **consumer key** and **consumer secret** and
the **integration user** the flow will run as.

## Add the auth provider

1. Go to **Configuration → Salesforce → Salesforce Authorization** (the Salesforce
   Suite's `salesforce.auth_config` screen).
2. Add a new authorization provider and choose the **Salesforce OAuth Client
   Credentials** provider type (supplied by this module).
3. Enter the connected app's **consumer key** and **consumer secret**, along with
   any other connection details the Salesforce Suite asks for (such as the login
   URL for your org or sandbox).
4. Save. The Salesforce Suite will use this provider to obtain and refresh access
   tokens for its API calls — no user interaction is involved, since this is a
   server-to-server flow.

## Handle the credentials securely

The consumer key and secret are sensitive. Rather than leaving them in exported
configuration, source them from the environment or a Key entity so they never land
in a config export or in version control. Always operate over HTTPS, and give the
connected app and its integration user the **minimum** Salesforce permissions the
integration needs — nothing more.
