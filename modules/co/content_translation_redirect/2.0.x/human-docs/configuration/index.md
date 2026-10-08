# Configuration

You configure the module by creating **redirect rules**. Each rule decides what
happens when someone requests content in a language it hasn't been translated into.

## Open the admin screen

1. Log in as a user with the **Administer content translation redirects** permission.
2. Go to **Configuration → Regional and language → Content Translation Redirect**, or
   navigate directly to `/admin/config/regional/content-translation-redirect`.

You'll see the list of redirect rules. The **Default** rule always sorts first and
cannot be deleted; it ships disabled.

## Add a rule

Click **Add content translation redirect**. You first pick a **Type** — the select
offers every supported entity type or bundle that doesn't already have a rule (a
readable label is filled in for you automatically). Choose whether the rule should
cover a whole entity type (e.g. *Node*) or a specific bundle (e.g. *Node: Article*),
then set the three fields below and save.

## The three settings on each rule

- **Redirect status** — the HTTP status code to send: **300, 301, 302, 303, 304, 305
  or 307**, or **"- Disabled -"** to keep the rule on file but do nothing. Use **301**
  for a permanent redirect (best for SEO) or **302** for a temporary one.
- **Redirect path** — where to send the visitor. Leave it **blank** to redirect to
  the *same* content in its original (untranslated) language — the most common choice.
  Or enter a Drupal path starting with `/` (for example a "content not available in
  your language" page).
- **Act on** — which content the rule applies to:
  - **translatable** — only content that is translatable,
  - **untranslatable** — only content that is not translatable,
  - **all** — every entity regardless of translatability.

## How rules are matched

When a request comes in for content in a missing language, the module applies the
**most specific** matching rule and stops:

1. a rule for the exact **bundle** (e.g. `Node: Article`), else
2. a rule for the whole **entity type** (e.g. `Node`), else
3. the **Default** rule.

So you can, for example, set a site-wide Default of 302 while giving Articles their
own 301 rule, and leave taxonomy terms on the Default. A rule with its status set to
"- Disabled -" is effectively a no-op — a handy way to switch a redirect off without
deleting it.

## Which content is supported

Rules can target content entity types that are translatable and expose a canonical
page. A few core types are excluded because they have no meaningful canonical page:
`block_content`, `comment`, `contact_message`, `menu_link_content` and `shortcut`.

Remember the whole feature only takes effect on **multilingual** sites.

## Setting rules from the command line

Each rule is stored as a config object named
`content_translation_redirect.entity.<id>` (for example
`content_translation_redirect.entity.node__article`). Read one back with:

```bash
drush cget content_translation_redirect.entity.node__article
```
