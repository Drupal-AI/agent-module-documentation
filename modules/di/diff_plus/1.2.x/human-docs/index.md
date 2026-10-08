# Diff Plus — manual setup guide

**Diff Plus** (`diff_plus`) adds an opinionated set of extensions to the contrib
[Diff](https://www.drupal.org/project/diff) module, which lets editors compare
two revisions of a piece of content. Where Diff gives you the basic revision
comparison, Diff Plus makes it richer and easier to read.

It ships two extra comparison formats: **Raw HTML**, a beautified side‑by‑side
source diff, and **Visual Inline (HTML5)**, an inline visual diff that shows the
rendered content with changes highlighted (and lets you switch between the
entity's view modes from a toolbar). It also refreshes the diff header — showing
revision authors, moderation/published status, previous/next revision links, and
a link to the full version history — and does a lot of quiet cleanup to reduce
false‑positive diffs (rendering revisions as an anonymous user, stripping Views
DOM‑id classes, contextual links, and HTML comments before comparing).

Its most unusual feature is **per‑user personalization**: each editor can tune
their own diff experience (which cleanups to apply, the beautifier settings, the
syntax‑highlighting theme, and so on) without changing the site‑wide defaults —
as long as you grant them the personalization permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Diff module and the `caxy/php-htmldiff` library) and enable it.

## Where it lives in the admin menu

Diff Plus adds two settings forms, both under **Configuration → Content
authoring**:

- **Site defaults** at `/admin/config/content/diff_plus/settings/default`
  (requires the core **Administer site configuration** permission) — sets the
  default diff behavior for everyone.
- **Personal settings** at `/admin/config/content/diff_plus/settings` (requires
  the **Personalize diff plus settings** permission) — lets an individual editor
  override the defaults just for themselves. These overrides are stored per user
  and merged on top of the site defaults when a diff is rendered.

## How to use it

**1. Turn on the comparison layouts.** The two formats Diff Plus adds are Diff
*layout plugins*, so you enable them in the **Diff module's own settings** at
**Configuration → Content authoring → Diff** (`/admin/config/content/diff/settings`),
under the layout plugins section — not on a Diff Plus form. Once enabled, *Raw
HTML* and *Visual Inline (HTML5)* appear as comparison‑format choices on any
entity's revision‑comparison page.

**2. Compare revisions.** Go to a content item's **Revisions** tab, pick two
revisions to compare, and choose the Raw HTML or Visual Inline format. Whoever
can already view an entity's revision diff (per the Diff module's and the
entity's revision‑view access) can use these layouts — Diff Plus adds no new
front‑end route or access path.

**3. Tune the behavior (optional).** On the site‑defaults form you can adjust:

- **Enhance diff UI** — replace the stock diff header with the richer Diff Plus
  header (authors, status, prev/next, history). *On by default.*
- **Preserve inline styles** (visual HTML5 diff) — keep inline `style` attributes
  through the visual diff. *On by default.*
- **Render anonymously** (raw HTML) — render each revision as an anonymous user
  before diffing, to avoid false positives from per‑user markup. *On by default.*
- **Strip contextual links / Views DOM‑id classes / HTML comments** (raw HTML) —
  three independent cleanups that cut noise from dynamic markup. *All on by
  default.*
- **Indent size, wrap line length, preserve newlines** — control the raw‑HTML
  beautifier's formatting.
- **Highlight style** — pick a syntax‑highlighting theme for the raw‑HTML diff
  from a large bundled list of highlight.js stylesheets.

The personal‑settings form offers the same options but saves them only for the
current user (and only takes effect if that user has the **Personalize diff plus
settings** permission). Every one of these settings is cosmetic or
noise‑reduction — none of them changes who can see a diff.

> **Note on external assets:** the Raw HTML diff loads its JavaScript helpers
> (`diff2html`, `jsdiff`, `js-beautify`, `highlight.js`) from public CDNs. If your
> site must self‑host all assets, you'll need to override those library
> definitions.
