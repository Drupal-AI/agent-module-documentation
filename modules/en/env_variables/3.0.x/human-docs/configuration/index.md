# Configuration

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Administration → Configuration → Environment Settings**
   (the `env_variables.config.form`).

## Setting the `.env` file path

The settings form lets you tell the module **where the `.env` file lives on the
server**, relative to the docroot. The module reads that file with the PHP dotenv
library. Examples of the path value:

- `/../` — a folder outside the docroot.
- `/` — the docroot folder itself.
- `/env` — a `docroot/env` folder.

Set the path to match where your project keeps its `.env` file, then save.

## Controlling who can view

By default the **administrator** role can reach the list page at
`/admin/config/env/list`. To change that, go to the **Permissions** page and find
**View Environment Variables** — assign it to the specific role(s) that should see
the page. As with any administrative page, grant this permission only to roles you
trust to see the site's configuration.

## Reading variables in custom code

The module exposes the `env_variables` service (class `DotEnvServices`). Inject it
into your own module's constructor and call `loadEnvFile($path)` to load the `.env`
file into the process environment, then read specific values with `getenv()`. This
is the tidy way to consume individual values in code. See the agent reference
[`agent/api/service.md`](../../agent/api/service.md) for the method signature.
