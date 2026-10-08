# Configuration

Nothing is tracked until you enter your Hotjar ID here and save.

## Open the settings form

1. Log in as a user with the **Administer Hotjar** permission (an administrator by
   default; otherwise grant it at `/admin/people/permissions`).
2. Go to **Configuration → System → Hotjar**, or navigate directly to
   `/admin/config/system/hotjar`.

All settings are saved to the `hotjar.settings` configuration object.

## Hotjar ID (required)

- **Hotjar ID** — your Hotjar site ID (Hotjar calls it the `hjid`). This is the one
  value the whole module hinges on: **no snippet is output while it is empty**.
  Paste the numeric ID from your Hotjar account. After changing it in *build* mode
  (the default delivery), rebuild caches (`drush cr`) so the generated snippet file
  is rewritten.
- **Snippet version** — the Hotjar embed version number (`hjsv`, default 6). Only
  change this if Hotjar tells you to.

## Page visibility

Decide which pages get the tracking snippet:

- **Add to every page except the listed pages** *(default)* — track the whole site
  except the paths in the **Pages** box.
- **Add to only the listed pages** — track *only* the paths in the **Pages** box
  (useful for tracking a couple of landing pages).
- **Do not add to any page** — a master off switch that leaves the ID configured but
  emits nothing.

The **Pages** textarea holds path patterns, one per line, and supports wildcards.
The shipped default already excludes the pages you almost never want to record:

```
/admin
/admin/*
/batch
/node/add*
/node/*/*
/user/*/*
```

Add your own exclusions here (e.g. `/checkout/*`) in the default "all except" mode,
or list the pages to include in "only listed" mode. Both the raw path and its URL
alias are matched.

## Role visibility

Decide which users get tracked, by role:

- **Roles** — the set of roles the rule applies to. If you leave it empty, all roles
  are tracked.
- The mode toggle controls how the selected roles are treated: track **only** the
  selected roles, or track **everyone except** the selected roles. For example,
  select the *Administrator* / editor roles and choose "everyone except" to avoid
  recording your own team.

## Snippet delivery (attachment mode)

How the tracking code is added to the page:

- **Build** *(default)* — the activation script is written to a JavaScript file
  (default path `public://hotjar/hotjar.script.js`) and added as a `<script src>` in
  the page head. The file is regenerated on a cache rebuild, so run `drush cr` after
  changing the ID.
- **drupalSettings** — the ID and version are passed via `drupalSettings` and the
  module's own library runs the snippet.

There is also a **Snippet path** setting for where the generated file is written in
build mode; the default is fine for most sites.

## Save

Click **Save configuration**. Tracking begins on the next matching page load.
Remember: in build mode, run `drush cr` after changing the ID so the snippet file is
regenerated.

## Always-on safety rules

Regardless of the above, the snippet is **never** emitted when:

- the Hotjar ID is empty;
- the response is a 403 or 404 error page;
- an EU Cookie Compliance consent check forbids it (if that module is installed and
  the snippet path is in its disabled-scripts list); or
- another module vetoes it through one of the module's access hooks.

## Permission

The **Administer Hotjar** permission gates access to this settings form only. It does
**not** control whether a given visitor is tracked — that is entirely the page and
role visibility settings above.

## Advanced integration (optional)

Other modules can hook into tracking: veto it per request, swap the Hotjar ID per
hostname/environment, or wrap the activation script for a custom consent gate. Those
hooks are documented in the [`agent/` hooks docs](../agent/hooks/hooks.md).
