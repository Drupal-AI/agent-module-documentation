# Configuration

Config Pages Overrides is configured per **Config Pages type**: you create one or more
*mappings*, each of which says "read this field from the config page, and use its value to
override this configuration item". There is no global settings page.

## Before you start

You need a Config Pages type that already has the field(s) you want to expose. For example,
to let an editor change the site name, create a Config Pages type with a plain **text**
field. Create the type and its fields under **Structure → Config pages types** first.

## Open the overrides form

1. Log in as a user who can **update** the Config Pages type (this is the access the form
   requires).
2. Go to **Structure → Config pages types → *(your type)* → Manage**, then open the
   **Config Overrides** tab, or navigate directly to
   `/admin/structure/config_pages/types/manage/{config_pages_type}/overrides`.
3. Use the **add** action (`.../overrides-add`) to create a new mapping.

## The mapping fields

Each override mapping is defined by these fields:

- **Field** — the Config Pages field whose value you want to use as the override source
  (for example, your site‑name text field).
- **Column** — which column of that field supplies the value. Most simple fields store their
  data in a `value` column; fields with several properties let you pick the right one.
- **Delta** — which item of a multi‑value field to read. Choose a single delta (0 for the
  first item), or select "unlimited" to pull the *whole* multi‑value field into the target
  configuration as an array.
- **Config name** — the target configuration object to override, such as `system.site`.
- **Config item** — the dotted path to the specific key inside that object, such as `name`,
  or `page.front`.
- **Prefix** / **Suffix** — optional text wrapped around a string value before it is
  applied (for instance, prefixing a path with `/`). These apply to string values only.

When the override runs, the module reads the live value from the Config Page, applies any
prefix/suffix, and **casts it to the target's schema type** — a boolean target receives a
real `true`/`false`, an integer target a real number — before injecting it into the
configuration.

## Save and combine

Save the mapping. You can add several mappings to one Config Pages type, overriding multiple
configuration items from the same page. The mappings are stored on the Config Pages type
entity itself, so they travel with your configuration exports.

## How it behaves and how to verify

Overrides are **dynamic**: they are layered on at read time and are *not* written back into
configuration storage. So the moment an editor changes the Config Page instance, the
overridden configuration changes site‑wide.

To confirm a mapping works, edit the Config Page instance to a known value, clear caches if
needed, then check the effective value:

```bash
drush config:get system.site name
```

You should see the value from your Config Page rather than the value stored on disk — that
difference is the override doing its job.

## Removing an override

To stop overriding a setting, return to the type's **Config Overrides** tab and remove the
mapping. The target configuration then reverts to its stored value.
