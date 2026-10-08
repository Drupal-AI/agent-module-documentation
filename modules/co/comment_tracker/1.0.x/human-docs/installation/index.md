# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`), PHP 8.1+.
- Core's **Comment** and **Node** modules enabled — this module builds a tracking layer on
  top of comments and only tracks comments attached to **nodes**.

There are no third-party Composer or PHP library requirements. This release is
marked *not covered* by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/comment_tracker
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/comment_tracker`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en comment_tracker -y
```

## Turn tracking on for a comment type

Tracking does nothing until you enable it on the comment type(s) you care about:

1. Go to **Structure → Comment types** (`/admin/structure/comment`) and edit a comment type
   (for the default article/page comments this is usually **Default comments**).
2. Tick **Enable Comment Tracker** in the *Comment Tracker Settings* section.
3. Save.

From then on, every node whose comment field uses that comment type is tracked for
signed-in visitors.

## Make the indicators visible (theme work)

The module exposes data but ships no markup or CSS. To show "new comment" indicators, a
front-end developer adds Twig to the theme:

- In `comment.html.twig`, use the `is_new_comment` boolean.
- In `node.html.twig`, use `comment_stats.new` / `.read` / `.total`.

Wrap your badge/counter in the documented CSS classes
(`comment-tracker-indicator__new_comment` for a per-comment badge,
`comment-tracker__comment_stats` for a node counter) so the module's JavaScript can remove
them automatically once a comment is read.

## Verify it worked

Sign in as a second user, view a node with tracked comments, and confirm your theme's
"new" indicators appear and then disappear a few seconds after each comment scrolls into
view. Bear in mind that per-user tracking adds cache contexts and records who read what —
confirm this fits your site's caching setup and data-handling policies before relying on it
on a busy site.
