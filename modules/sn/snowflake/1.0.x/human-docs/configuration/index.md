# Configuration

Snowflake will not connect until you tell it which Snowflake account to talk to
and how to authenticate. All of the forms below require the **`administer
snowflake`** permission (an administrator by default), and they live under
**Configuration → Snowflake**.

## 1. Store your credentials in a Key first

Before filling in the authentication form, create a **Key** entity (from the Key
module) holding your Snowflake credential — your private key for key‑pair
authentication, or your OAuth secret. Snowflake references this Key rather than
storing the raw secret in its own configuration, which keeps the credential out
of exported config. You select the Key on the authentication form in the next
steps.

## 2. Snowflake Settings — account identifier and statement defaults

Go to **Configuration → Snowflake → Snowflake Settings**
(`/admin/config/snowflake/settings`). Here you set:

- **Account identifier** — the identifier for your Snowflake account. The client
  builds the API endpoint from this value
  (`https://{account}.snowflakecomputing.com/api/v2/statements`), so it must be
  correct for requests to reach your account.
- **Statement / parameter defaults** — default settings and parameters applied to
  the SQL statements you run, so you do not have to specify them on every call.

## 3. Snowflake Authentication — choose a method

Go to **Configuration → Snowflake → Snowflake Authentication**
(`/admin/config/snowflake/auth`). Pick the authentication method the client will
use. The supported method is **Key Pair Authentication**; an OAuth path exists in
the code but its form is currently disabled, so key‑pair is the practical choice.

## 4. Key‑pair settings

For key‑pair authentication, the private‑key details are set on the key‑pair form
(`/admin/config/snowflake/auth/key-pair`). This is where you point the module at
the **Key** entity holding your private key (created in step 1). Key‑pair
authentication signs a JWT with that private key on each request, which is why the
`firebase/php-jwt` library must be installed (see
[Installation](../installation/index.md)).

## Save and verify

Save each form. If an authentication method is selected but not fully configured,
the client raises an error when you try to use it, so complete all of the fields
above before calling `snowflake.sql_api` from code. Once the account identifier
and key‑pair details are in place, the client can obtain a bearer token and send
statements to your Snowflake account.
