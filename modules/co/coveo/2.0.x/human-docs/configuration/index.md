# Configuration

Configuring Coveo has three parts: **connecting** to your Coveo organization with
credentials (stored securely), **indexing** your content through Search API, and — if
any content is access-restricted — turning on **secured search**. Work through them in
that order.

## Before you start: store the Coveo credentials as secrets

Coveo authenticates your site to its cloud platform with **API keys**. These are
secrets. Never paste them into a settings form that gets exported to configuration,
and never commit them to version control. Store the value in an environment variable
and reference it from Drupal through a **Key** entity.

With DDEV, the recommended pattern is:

1. Save the value into DDEV's dotenv file (the flag name becomes the variable name):

   ```bash
   ddev dotenv set .ddev/.env --coveo-api-key=<value>
   ddev restart
   ```

   Keep `.ddev/.env` out of version control.

2. Confirm the variable is present in the container **without printing its value**:

   ```bash
   ddev exec 'test -n "$COVEO_API_KEY"'   # exit status 0 means it is set
   ```

3. Install the **Key** module if it isn't already enabled, then create a Key that
   reads the environment variable:

   ```bash
   ddev composer require drupal/key
   ddev drush en key -y
   ddev drush key:save coveo_api_key --label='Coveo API Key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"COVEO_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

Then, in Coveo's connection settings, select the **Key** you created rather than
typing the secret inline. (If a particular field does not support a Key entity,
reference the environment variable from `settings.php` with `getenv('COVEO_API_KEY')`
instead.)

**Egress caveat:** this module makes outbound HTTPS calls to Coveo's API to push
content and run searches. Your Drupal environment must be allowed to reach Coveo's
endpoints — behind a restrictive firewall or in an isolated CI/test environment those
calls will fail. Always use HTTPS so credentials are never sent in the clear.

## 1. Connect to your Coveo organization

Using the credentials above, connect the module to your Coveo **organization** and
target **index**. Version 2 also supports linking **multiple environments** — for
example linking a production organization read-only so you can preview changes safely.
Provide the organization ID and the API key (via the Key entity), and confirm the
connection before indexing.

## 2. Index content with Coveo Search API

Content reaches Coveo through Drupal's **Search API** framework, provided by the
`coveo_search_api` submodule:

1. Go to **Configuration → Search and metadata → Search API**
   (`/admin/config/search/search-api`).
2. Create a **Server** that uses the **Coveo** backend, and point it at your Coveo
   organization/index using the connection you configured above.
3. Create an **Index** on that server, choose the entity types to index (for example
   Content), and add the fields you want searchable.
4. Run indexing (from the index page, or with `drush search-api:index`) to push your
   content up to Coveo.
5. Optionally, index **user identities** as well, which is what secured search relies
   on to map Coveo results back to who is allowed to see them.

## 3. Turn on secured search for restricted content

If **any** indexed content is not fully public, enable and configure
`coveo_secured_search`. A hosted Coveo index is **not** governed by Drupal's entity
access on its own — without secured search, restricted content indexed to Coveo can be
returned to users who should not see it. Secured search issues **search tokens** tied
to the requesting user so results are filtered to what that user is permitted to view.
Configure the security provider, ensure identities are indexed, and test as an
anonymous user and as a restricted role to confirm private content does not appear.

## 4. Render the search experience (Coveo Atomic)

With `coveo_atomic` enabled, place the Coveo Atomic **block** where you want search to
appear (under **Structure → Block layout**), and use the module's Atomic development
tools to assemble the search interface (search box, results, facets, sorts) from
Coveo's web components.

## Permissions

Coveo provides its own permissions — grant them under **People → Permissions**
(`/admin/people/permissions`) to the roles that should administer the integration.
Keep administrative access to trusted staff, since it governs an external service
holding a copy of your content.

## Save and verify

After connecting, indexing, and (if needed) enabling secured search, run a few
searches: confirm public results appear, and — importantly — confirm that restricted
content is hidden from users who lack access. If searches return nothing, re-check the
credentials/Key, the egress path to Coveo, and that indexing actually ran.
