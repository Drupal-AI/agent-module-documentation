# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- Core's **Filter** and **CKEditor 5** modules (enabled by default on standard
  sites).
- Two contributed dependencies that Composer pulls in: **CKEditor AI Agent**
  (`ckeditor_ai_agent`) and **Maxlength** (`maxlength`). The **Analyze**,
  **Analyze AI Brand Voice**, and **Analyze AI Sentiment** modules are optional
  (suggested) add-ons for content scoring, not required.
- For the AI-assisted editing: a configured AI provider with a key (stored as a
  secret) in the CKEditor AI Agent module. No per-platform API keys or tokens are
  needed — the module drafts copy, it does not post to any network.

There are no additional third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_social_posts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in and update the
contributed dependencies listed above.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_social_posts -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_social_posts -y
```

## Submodules — enable only the platforms you use

AI Social Posts ships sixteen per-platform submodules. Enable only the ones you
write for, each with `drush en`:

| Platform | Machine name |
|----------|--------------|
| X | `ai_social_posts_x` |
| LinkedIn (posts) | `ai_social_posts_linkedin` |
| LinkedIn (articles) | `ai_social_posts_linkedin_article` |
| Facebook | `ai_social_posts_facebook` |
| Instagram Reels | `ai_social_posts_instagram_reels` |
| Instagram Story | `ai_social_posts_instagram_story` |
| Reddit | `ai_social_posts_reddit` |
| TikTok | `ai_social_posts_tiktok` |
| YouTube | `ai_social_posts_youtube` |
| YouTube Shorts | `ai_social_posts_youtube_shorts` |
| Bluesky | `ai_social_posts_bluesky` |
| Medium | `ai_social_posts_medium` |
| Substack | `ai_social_posts_substack` |
| Hacker News | `ai_social_posts_hackernews` |
| Newsletter | `ai_social_posts_newsletter` |
| Example (reference) | `ai_social_posts_example` |

For example, to draft for X and LinkedIn:

```bash
drush en ai_social_posts_x ai_social_posts_linkedin -y
```

Each submodule requires the base AI Social Posts module, which is already
present once you have installed it above.

## After enabling

Each platform submodule you turn on adds its bundle automatically — there are no
per-platform credentials to enter. Configure the **CKEditor AI Agent** module
with your AI provider and key (stored as a secret) so the in-editor AI button
works, then start drafting from a node's **Socials** tab or at **Content › Social
Posts › Add**. Finished drafts stay in Drupal; copy them to each platform
yourself when ready.
