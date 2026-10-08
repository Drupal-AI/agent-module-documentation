# Group Media Library Extra — manual setup guide

**Group Media Library Extra** (`group_media_library_extra`) adds extra
functionality on top of the
[Group Media Library](https://www.drupal.org/project/group_media_library) module,
giving you finer control over which media items people can pick from the Media
Library when working inside (or outside) a group.

Its headline feature is a pluggable **media library view**: you can decide, per
group type, what set of media items the Media Library shows — and you can set a
separate rule for content created outside any group ("global" content). This keeps
groups from accidentally reusing each other's media, and keeps group media from
leaking into non-group content.

The module ships several ready-made "media source" plugins you can choose from:

- **Own media items** — users only see the media items they own.
- **Group's media items** — users only see media associated with the current
  group (this requires the Group Media / `groupmedia` module).
- **Media without group** — used when content is created outside a group context,
  so that media belonging to a group cannot be used there (also requires Group
  Media).

If none of those fit, developers can write a custom plugin. Media access within
groups still follows the Group / Group Media Library access model — this module
shapes *which items appear in the picker*, not the underlying access rules, and it
has no access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it on top of Group Media Library.
2. [Configuration](configuration/index.md) — choose the media item source per
   group type, and for global (non-group) content.

## Where it lives in the admin menu

Group Media Library Extra is configured in two places:

- **Per group type** — the **Media library** tab on the group type (**Groups →
  Group types → *(your group type)*** → *Media library*).
- **Globally** — **Groups → Settings → Media Library Extra Settings**, which
  controls the media source for content created outside any group.

See [Configuration](configuration/index.md) for the details.
