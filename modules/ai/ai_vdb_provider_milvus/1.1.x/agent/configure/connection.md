<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Milvus/Zilliz connection

Single config form at **`/admin/config/ai/vdb_providers/milvus`** (route
`ai_vdb_provider_milvus.settings_form`, permission **`administer ai providers`** — defined by the `ai`
module, not this one). Form class `src/Form/MilvusConfigForm.php`.

## Config object `ai_vdb_provider_milvus.settings`

| Key | Type | Default (config/install) | Meaning |
|---|---|---|---|
| `server` | string (URL) | `''` | Full base URL of the Milvus/Zilliz endpoint. Local DDEV: `http://milvus`. Zilliz: the "Public Endpoint" URL. Trailing `/` is stripped on save. |
| `port` | int | `null` | Server port. Local Milvus: `19530`. Zilliz Cloud: `443`. |
| `api_key` | string | `''` | Machine name of a **Key** entity (`key_select` element) holding the auth secret — NOT the secret itself. Optional (e.g. local DDEV Milvus with no auth). |

Requests are made to `<server>:<port>`. When `api_key` is set, its Key value is sent as
`authorization: Bearer <value>`. For Milvus the value should be `username:password`; for Zilliz it is
the API token.

## Validation behaviour (form)

- `server` must pass `FILTER_VALIDATE_URL`; `port` must be numeric if provided.
- The form **pings the server** through the provider plugin (`createInstance('milvus')->ping()`) using
  the entered values before it will save — a bad host/credential blocks the save with
  "Could not connect to the server."

## Set it without the UI (drush)

```bash
# Reference an existing Key entity 'milvus_auth' (create it with the Key module first).
ddev drush cset ai_vdb_provider_milvus.settings server 'http://milvus' -y
ddev drush cset ai_vdb_provider_milvus.settings port 19530 -y
ddev drush cset ai_vdb_provider_milvus.settings api_key milvus_auth -y
```

(Direct `cset` skips the ping validation the form runs.)

## Storing the credential (Key module)

`api_key` is a **Key** machine name, so the secret can live in an env var or file via the Key module's
providers rather than in this config. Create the Key first (Configuration → System → Keys), then pick it
in the `api_key` select. Leave `api_key` empty for an unauthenticated local Milvus.

## Local Milvus with DDEV

The module ships `docs/docker-compose-examples/ddev-example.docker-compose.milvus.yaml`. Copy it to
`.ddev/docker-compose.milvus.yaml`, `ddev restart`, then use `server=http://milvus`, `port=19530`
(Milvus UI at `https://<project>.ddev.site:8521`).

## Where it's used

Once configured, select this **milvus** provider as the Vector Database backend when creating an
**AI Search** server/index (provided by the `ai_search` module). This module supplies the storage
backend; the embedding generation and indexing are driven by `ai` / `ai_search`.
