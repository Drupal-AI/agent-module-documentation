# Rules Token — manual setup guide

**Rules Token** (`rules_token`) lets you use Drupal **tokens** inside **Rules**.
Out of the box Rules cannot easily read a token like `[node:title]` or
`[webform_submission:values:message]` into a rule; this module adds one Rules
**action** and two Rules **conditions** that resolve tokens to values and
compare them — including tokens provided by the Token, Custom Tokens, and Custom
Tokens Plus modules.

The action, **Get token value**, runs a token through Drupal's token system and
hands the result to later Rules steps as a new `token_value` variable — so you
can, for example, capture a webform field value after submission and drop it
into a "Send email" body. The two conditions, **Compare Data with Token** and
**Compare Token with Token**, let you branch a rule on a token's value: compare a
token against a literal value, or compare two tokens against each other, using
the operators `==` (default), `<`, `>`, `CONTAINS`, and `IN`.

There is no settings page and nothing to configure globally — you use these
plugins from inside the Rules UI when you build a reaction rule or component. So
this guide folds the "how to use it" notes into this page rather than a separate
configuration chapter.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent — including the exact plugin ids and contexts — read the
sibling [`agent/`](../agent/start.md) docs, especially
[`agent/configure/rules.md`](../agent/configure/rules.md).

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module together with its Rules and Token dependencies.

## How to use it

You add these to a rule from **Configuration → Workflow → Rules**
(`/admin/config/workflow/rules`), inside a reaction rule or component:

- **Get token value** (action) — supply a **token** string (e.g.
  `[node:title]`) and, for a token bound to an entity, an **Entity of Token**
  (select the entity via the data selector). The resolved text becomes the
  `token_value` variable, usable in any later action. Global tokens such as
  `[date:html_date]` or `[site:url]` need no entity — leave that field empty.
- **Compare Data with Token** (condition) — evaluates *your data value* against
  a resolved token, using the chosen operator. Good for "does this webform field
  equal the expected value?" branching.
- **Compare Token with Token** (condition) — resolves two tokens and compares
  them to each other (e.g. two date tokens).

Two conveniences make this easier: unresolved tokens are cleared to an empty
string rather than leaking the raw `[...]` text, and the Rules expression edit
form gains a **Browse available tokens** link next to the token fields so you
can discover what is available.

## Where it lives in the admin menu

There is no page of its own. The action and conditions appear inside the Rules
builder at **Configuration → Workflow → Rules**
(`/admin/config/workflow/rules`).
