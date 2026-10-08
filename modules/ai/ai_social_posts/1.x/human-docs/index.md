# AI Social Posts — manual setup guide

**AI Social Posts** (`ai_social_posts`) gives you a single place in Drupal to
**draft** social media copy, platform by platform, with AI assistance. It
provides a **social-post content entity** whose bundles — one per platform,
supplied by a **per-platform submodule** — each carry a platform-tuned writing
prompt and character limit. You enable only the channels you actually write for.

Out of the box it ships submodules for **X**, **LinkedIn** (posts and
articles), **Facebook**, **Instagram** (Reels and Story), **Reddit**,
**TikTok**, **YouTube** (and Shorts), **Bluesky**, **Medium**, **Substack**,
**Hacker News**, a **newsletter** channel, and an **example** module to learn
from — sixteen in all. Content creation is AI-assisted, drawing on the
CKEditor AI agent and, optionally, the Analyze brand-voice/sentiment tooling.

An important point on scope: this module is a **content-authoring tool, not a
publishing bridge**. It stores your drafted copy as Drupal content entities and
does **not** connect to, authenticate with, or post to any social network — there
are no per-platform API keys or tokens to enter, and nothing is auto-posted. When
a draft is ready you copy it to the platform yourself. The only external key
involved is the **AI provider key**, which lives in the CKEditor AI Agent module's
own configuration (store it as a secret, since AI generation sends content out to
that provider).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the base module with
   Composer, enable it, and turn on only the platform submodules you need.

## Where it lives in the admin menu

The base module registers a **social-post content entity**, which you create and
manage from the site's content administration area (**Content › Social Posts**,
`/admin/content/ai-social-posts`). The platform bundles are listed under
**Structure › AI Social Post Types**. Each per-platform submodule simply adds one
bundle (with its prompt and fields) when enabled — there is no per-platform
settings/credentials screen. You can also draft a post straight from any node's
**Socials** tab.

## How to use it

1. Enable the base module and only the platform submodules you write for
   (see [Installation](installation/index.md)).
2. Configure the **CKEditor AI Agent** module with your AI provider and key
   (store the key as a secret) so the in-editor AI button works.
3. From a node's **Socials** tab, or at **Content › Social Posts › Add**, pick a
   platform and use the AI-assisted editor to draft and refine the copy; the
   character limit for that platform is enforced as you type.
4. Save the post. When you are happy with it, **copy the text to the platform
   yourself** — the module keeps the draft, it does not post for you.
5. Optionally, grant the AI Social Post permissions to the editor roles that
   should be able to add, view, edit, or delete these drafts.
