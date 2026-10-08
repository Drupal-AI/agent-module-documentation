# Configuration

Field Defaults has one small global setting, a per‑field section that actually triggers the
update, and a Drush command for scripting. In all cases the value written is the field's
**own configured default value**, so always set the field's *Default value* first.

## Global setting

Go to **Configuration → System → Field defaults settings**
(`/admin/config/system/field_defaults/settings`). Reaching it requires the core **Access
administration pages** permission (`access configuration pages`). There is one checkbox:

- **Retain original entity updated time** *(on by default)* — when ticked, a bulk update
  preserves each entity's original *changed*/updated timestamp instead of bumping it to
  "now". Leave it on so that mass‑backfilling a default does not re‑sort all your content by
  update date. Untick it if you actually want the updated entities to register as freshly
  changed.

## Permission

The module defines one permission, **Administer field defaults** (`administer field
defaults`). It is a restricted permission that controls who sees the **"Update existing
content"** section on a field's edit form. Grant it only to trusted admin roles — it lets a
user rewrite a field's value across every entity of a type in one action. Without it, field
edit forms look exactly as they normally do.

## Running a bulk update from the field edit form

1. Go to the field under **Structure → (entity type) → Manage fields → (field) → Edit**.
2. First, set or confirm the field's **Default value** — this is the value that will be
   written to existing content.
3. Open the **"Update existing content"** section (you need the *Administer field defaults*
   permission) and choose:
   - **Overwrite existing content with the selected default value(s)** — tick this to run
     the update when you save the field.
   - **Additionally update entities of the following languages** — a checklist that only
     appears when both the bundle and the field are translatable, letting you also update
     specific translations.
   - **Keep existing values** — tick this to write the default *only* where the field is
     currently empty, leaving any editor‑entered values untouched. Leave it unticked to
     overwrite every entity.
4. **Save** the field. The update runs immediately as a batch over every matching entity,
   and you get a confirmation of how many entities were updated.

## Running a bulk update from Drush

The same operation is available as a command — ideal for deploy or update hooks and CI. The
value applied is still the field's stored default; the command does not take a value
argument.

```
field_defaults:bulk-update <entity_type> <entity_bundle> <field_name> [<lang>] [<no_overwrite>]
```

Aliases: `fdbu`, `field_defaults-bulk-update`. The arguments are:

- **entity_type** — e.g. `node`, `user`, `taxonomy_term`.
- **entity_bundle** — e.g. `article`. (Bundle‑less types such as `user` still need a value
  here; it is ignored for types that have no bundle.)
- **field_name** — the machine name, e.g. `field_region`.
- **lang** *(optional)* — comma‑separated language codes whose translations should *also* be
  updated, e.g. `de,fr`. Empty means the current language only.
- **no_overwrite** *(optional, default TRUE)* — `TRUE`/`1` fills only empty fields; `FALSE`/`0`
  overwrites existing values too.

Examples:

```bash
# Fill field_region on existing Articles only where it is empty (the default behaviour):
drush field_defaults:bulk-update node article field_region -y

# Overwrite field_region on ALL existing Articles with the field's default:
drush fdbu node article field_region '' 0 -y

# Also update the German and French translations, overwriting existing values:
drush fdbu node article field_region de,fr 0 -y
```

The command prompts for confirmation before running; pass `-y`/`--yes` to run it unattended
in a script. If the field does not exist or has no default value set, it reports that and
makes no changes — another reminder to set the field's **Default value** first.
