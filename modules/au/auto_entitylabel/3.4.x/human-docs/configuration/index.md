# Configuration

Automatic Entity Labels is configured **one bundle at a time** — there is no global settings page. Everything below happens on a bundle's **Automatic label** tab, and until you set a behavior there the module does nothing. Settings are stored per bundle in config named `auto_entitylabel.settings.<entity_type>.<bundle>`.

## Open the Automatic label tab

You need the *administer {entity_type} labels* permission for the entity type you want to configure (for example *administer node labels*). This permission is flagged *restrict access*, so grant it only to trusted roles — see the [`agent/permissions`](../../agent/permissions/permissions.md) doc for the full list.

Then browse to the bundle you want and open its **Automatic label** tab. For a content type that is:

**Structure → Content types → (your type) → Automatic label** — e.g. `/admin/structure/types/manage/article/auto-label`.

The same tab appears on taxonomy vocabularies, media types, comment types, and other qualifying bundles.

## Choose an automatic label behavior

The top of the form asks how the label should be handled. Pick one:

- **Disabled** — no automatic label; the field behaves normally. (This is the default until you change it.)
- **Automatically generate the label and hide the label field** — the label is always generated from your pattern and the label field is removed from the edit form entirely. Use this when editors should never see or type a title.
- **Optional** — the label field stays visible, but if an editor leaves it empty it is auto‑generated from the pattern. Good when you want a sensible fallback while still allowing a manual title.
- **Prefilled** — the label field is pre‑populated with the pattern so editors can tweak the suggested value before saving. Note that prefill mode has limited token support — id‑based tokens such as `[node:nid]` are not yet available because the entity has no id yet.

## Pattern

The **Pattern** field is the heart of the module: it defines the text of the generated label, using tokens. For example:

```
[node:field_first] [node:field_last]
```

or mixing static text with tokens:

```
Invoice [node:field_number]
```

Leave it blank to fall back to the default generated label. If you installed the **Token** module, a token browser appears here so you can pick valid tokens for this entity type instead of remembering them.

## Remove special characters

The **escape** option, when enabled, strips all special characters from the generated result — handy for producing clean, predictable labels.

## Preserve existing titles

**Preserve titles** keeps the labels of content that already exists when you turn on automatic labels, so enabling the feature doesn't rewrite history. This option only applies with the *generate‑and‑hide* behavior.

## When the label is generated

This setting controls timing:

- **Before save** — faster; the label is built before the entity is first written. Id‑based tokens like `[node:nid]` are *not* available yet, because the entity has no id at this point.
- **After save** — supports every token, including id‑based ones, at the cost of saving the entity twice.

Choose *before save* for speed when you don't need id tokens, and *after save* when your pattern references the entity's own id.

## Re‑save existing content

If you change a pattern and want it applied to content that already exists, use the batch **re‑save** option. It walks through all existing entities of this bundle and regenerates their labels, processing a configurable **chunk** of entities per batch step so large sites don't time out. Trigger it from the form and let the batch run to completion.

## Save

Click **Save configuration** to store the settings for this bundle. Remember to repeat the process for every bundle that should have automatic labels — the settings you just entered apply to this one bundle only.
