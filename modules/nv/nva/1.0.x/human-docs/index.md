# NVA Integration — manual setup guide

**NVA Integration** (`nva`) connects Drupal to **NVA (Nasjonalt vitenarkiv)**, the
Norwegian national research archive, exposing its Cristin research data — people,
organizations, projects, publications, funding sources, keywords and more — inside
your site. It is built on the `stinis87/nva` PHP client and depends on the **Key**
module, which it uses to store its API credentials.

The module gives you two ways to surface that data. First, it provides **blocks**
that display a person's publications and projects; these can be placed through the
block layout or rendered directly in Twig. For example:

```twig
{{ drupal_block('nva_list_publications', {
  'label': 'My publications',
  'authorName': node.label,
  'results_per_page': 15,
}) }}
```

Second, it provides an **API Client service** that makes requests to the NVA/Cristin
API straightforward — searching and exporting publications, fetching persons,
organizations, projects, categories, countries, funding sources and keywords by id
or by query parameters. Reach for the service when you need NVA data in custom code
rather than a ready‑made block.

This is an **integration** feature with no content‑access role of its own. It
exchanges data with an external national service over HTTPS (egress), so handle any
personal data it returns in line with your privacy obligations. Credentials are
handled correctly — stored as a **Key**, not as plain configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Key module and the `stinis87/nva` client) and enable the module.

Credentials are stored through the Key module and the blocks are placed via block
layout or Twig — both covered in "How to use it" below.

## Where it lives in the admin menu

NVA credentials are managed as **Key** entities under **Configuration → System →
Keys** (`/admin/config/system/keys`). The display blocks (such as **NVA List
Publications**) are placed from **Structure → Block layout**
(`/admin/structure/block`) or embedded directly in a Twig template.

## How to use it

1. **Store the API credential as a Key.** Keep the NVA API credential out of plain
   configuration. Save it into DDEV's environment and reference it through a Key:

   ```bash
   ddev dotenv set .ddev/.env --nva-api-key=<value>
   ddev restart
   ddev exec 'test -n "$NVA_API_KEY"'   # exit status 0 means it is set
   ddev drush key:save nva_api_key \
     --label='NVA API Key' \
     --key-type=authentication \
     --key-provider=env \
     --key-provider-settings='{"env_variable":"NVA_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

   Then select that Key in the module's settings so it authenticates against the
   NVA API. (If the integration does not require an API key for the endpoints you
   use, you can skip this step.)
2. **Place a block.** Go to **Structure → Block layout**, place a block such as
   **NVA List Publications** in a region, and configure its options (label, author
   name, results per page). Alternatively, render it in Twig with `drupal_block()`
   as shown above.
3. **Or call the service.** From custom code, use the NVA API Client service to
   search publications or fetch persons, organizations, projects and related data
   by id or query parameters.

> **Egress.** Because the module makes outbound HTTPS requests to the NVA/Cristin
> API, ensure your environment is allowed to reach it. In hosting that filters
> outbound traffic, allow egress to the NVA API host.
