# Example configs: drupal.org external entities

This module is a demonstration. Enabling it imports optional config (`config/optional/`) that defines
two working external entity types plus their fields, view/form displays, and Views. Use it as a
reference for how a REST and a JSON:API storage client are wired, then clone and adapt.

## What gets installed

| External entity type | Storage client | Source endpoint | Collection path | View |
|---|---|---|---|---|
| `drupalorg_rest_issue` (read only) | `rest` | `https://www.drupal.org/api-d7/node.json` | `/drupalorg-rest-issue` | `/drupalorg-rest-issue-view` |
| `drupalorg_jsonapi_module` (read only) | `jsonapi` | `https://www.drupal.org/jsonapi` | `/drupalorg-jsonapi-module` | `/drupalorg-jsonapi-module-view` |

Both include a `field_body` field; `drupalorg_rest_issue` also adds `field_issue_category`,
`field_issue_priority`, `field_issue_status`. The field mappings show the parent's mapping pipeline in
action — e.g. `field_body` uses a `generic` field mapper whose `value` property uses a `simple`
property mapper (`mapping: body.value`) and whose `format` is a `constant` (`full_html`), while
`field_issue_category` maps a code to a label with a `mapping` (value-mapping) data processor
(`1 → Bug report`, `2 → Task`, …).

## Try it

After enabling, visit `/drupalorg-rest-issue` (or the Views paths above) to browse live drupal.org
data. Inspect the type at `/admin/structure/external-entity-types/drupalorg_rest_issue` to see the
storage client and field mappings, or read the YAML in this module's `config/optional/`.

Known demo caveats (from the module README): the pager may not appear, and Views "Preview" can error.
The module suggests turning these examples into a recipe / a Project Browser storage client in future.
