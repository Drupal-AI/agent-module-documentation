# Configuration

Configuring InfluxDB is a two-step job: first store your access token as a **Key**,
then enter the connection details on the settings form. If you enabled the bucket
submodule, there is a third, optional step for managing buckets.

## Step 1 — store the token as a Key

The module never keeps your InfluxDB token in plain configuration; it references a
**Key** entity instead. Create that Key first.

The cleanest approach is to keep the token in an **environment variable** and point
a Key at it, so the secret never lands in the database or in exported config. In a
DDEV project, for example, save the value into DDEV's dotenv file and restart so
the container picks it up:

```bash
ddev dotenv set .ddev/.env --influxdb-token=<your-token>
ddev restart
```

That makes the token available inside the container as the `INFLUXDB_TOKEN`
environment variable (never commit `.ddev/.env`). Then create a Key that reads it,
using the **environment** key provider and the **Authentication** key type — the
settings form only offers Keys of the authentication type.

If you prefer, you can create the Key entirely through the UI at **Configuration →
System → Keys** (`/admin/config/system/keys/add`): give it an *Authentication*
key type and choose whichever provider suits your hosting (environment variable is
recommended over storing the raw value in configuration).

## Step 2 — the connection settings form

Go to **Configuration → Web services → InfluxDB**
(`/admin/config/services/influxdb`). This page requires the *administer influxdb*
permission (an administrator by default). Fill in:

- **Server URL** — the base URL of your InfluxDB server. Use an **`https://`** URL
  so traffic is encrypted; the module follows whatever scheme you enter and never
  disables TLS certificate verification.
- **Organization** — your InfluxDB organization name. On save the module resolves
  and confirms its organization ID.
- **Token** — a select list of your Keys (authentication type). Pick the Key you
  created in Step 1. Only the Key's ID is stored here; the secret stays in the Key
  provider.
- **Allow redirects** — whether the HTTP client should follow redirects from the
  server. Leave off unless your setup needs it.
- **Debug** — enables verbose HTTP debug logging. Handy while troubleshooting a
  connection, but leave it off in production.

When you save, the form **pings the server and reports the InfluxDB version** — if
you see the version, the URL, organization, and token are all working. If it
cannot connect, re-check the URL and that the Key resolves to a valid token.

> **Rotating the token later** is easy: update the value the Key points at (for
> example the environment variable), and the module picks up the new token with no
> configuration change.

## Step 3 (optional) — managing buckets

If you enabled **InfluxDB Bucket** (`influxdb_bucket`), you get a bucket manager
at **`/admin/config/services/influxdb/buckets`** (permission *administer influxdb
bucket*). Add a bucket config entity with a **label** and a **retention period**
(in seconds); saving it creates the bucket on the remote server if it does not
exist, or updates its retention if it does.

## Using it from ECA or custom code

With the connection configured, the ready-to-use client is available as the
`influxdb.services.client` service, and the **InfluxDB Bucket ECA** submodule
exposes *Create a Point*, *Write Point*, and *Execute a Flux query* actions for
ECA models. In every case the data written and the queries run come from
admin-authored code or ECA configuration — not from visitor request input — so
there is no end-user query-injection surface to worry about.
