# Enabling per-feed XML mapping override

There is no admin settings page. Configuration is two checkboxes injected into an existing feeds_ex
XML feed type's *Mapping* form, plus a per-feed override form on each Feed.

## 1. Opt a feed type in (once, by an admin)

Go to `admin/structure/feeds/manage/{feed_type}/mapping` for a feed type whose parser is **XML**
(the checkboxes only appear when `getParser()->getPluginId() === 'xml'`). In the
*Override mapping per feed* details element:

- **Override source mapping** (`source`) — enables per-feed XPath overrides.
- **Override source mapping configuration** (`source_configuration`) — additionally exposes each
  target's configuration subform and the per-property *Unique* checkbox on the per-feed form.
  Only visible/relevant when *source* is checked.

Saving stores these as third-party settings on the feed type:

```
feeds.feed_type.{type}:
  third_party_settings:
    feeds_ex_xml_mapping:
      source: true
      source_configuration: false
```

Config schema: `feeds.feed_type.*.third_party.feeds_ex_xml_mapping` (both `boolean`).
Set them programmatically with `$feed_type->setThirdPartySetting('feeds_ex_xml_mapping', 'source', TRUE)`.

## 2. Override mappings on an individual feed

Once *source* is on, each Feed's add/edit form (`XmlParserFeedForm`) shows:

- **Context** (required, maxlength 1024) — the base XPath query selecting each item.
- **XPath Parser Settings** table — one row per mapped target with a textfield for that target's
  XPath. A new feed is pre-filled from the feed type's current mappings
  (`XmlMappingHelper::getMappingsFromFeedType()`); an existing feed shows its own stored values.
- With *source_configuration* on: a *Configure* column (the target plugin's own settings subform)
  and a *Unique* checkbox column per property.

Non-XPath sources (mappings whose value does not start with `xpath_`, e.g. `parent:*`) are shown
read-only and passed through unchanged.

## 3. Where the override lives and how it is applied

On submit, the form writes to the **Feed entity** (not the feed type), under
`config[0]['xml_parser']`:

```
config:
  - xml_parser:
      context: '<xpath>'
      mappings: [ { target, map, unique, settings } ... ]
      custom_sources: { xpath_<target>_<prop>: { label, value, machine_name } ... }
```

At import, `UpdateMappingsSubscriber` (on `FeedsEvents::INIT_IMPORT`, priority 1024, before parsing)
loads that value and calls `setMappings()`, `set('custom_sources', …)`, and rewrites
`parser_configuration.context.value` on the in-memory feed type, so the standard feeds_ex XPath
parser runs with this feed's overrides. The stored feed-type mappings are the fallback for feeds that
have no override. See [api/internals.md](../api/internals.md) for the classes involved.

Note (upgrade): update hook `feeds_ex_xml_mapping_update_9501` migrates settings from an old
mis-spelled key `feed_ex_xml_mapping` to `feeds_ex_xml_mapping`.
