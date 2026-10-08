# Configuration

Drupacle is configured by creating one or more **Oracle connections**. Each
connection stores the details needed to reach an Oracle database and is given a
short‑code you then reference from your code.

## Open the connection manager

1. Log in as a user who holds the Drupacle administration permission (an
   administrator by default). Keep this permission restricted to trusted users —
   it controls who can define connections and run queries.
2. Go to **/admin/drupacle/connections**.

## Create a connection

Add a new connection and provide its Oracle details — typically the host, port,
service name / SID, username, and password (the exact fields depend on your Oracle
setup). Save it, and Drupalce makes an "Oracle database object" available via a
short‑code. You can create several connections to talk to multiple Oracle
databases.

Once a connection exists, copy its short‑code and use it in your PHP/module code
to run queries against that Oracle database through the OCI8 functions.

## Where the connection details are stored

Drupacle saves each connection — host, port, service name / SID, username, and
password — in that connection's own configuration. Because the password is held
there, restrict the Drupacle permissions to trusted users, and be mindful of where
your site's configuration is exported or copied to.

## Running queries

You run queries against the Oracle database yourself, from your own PHP/module
code, using the connection's short‑code and PHP's OCI8 functions. Follow normal
database practice — use bind variables rather than concatenating input into SQL —
just as you would for any hand‑written query.
