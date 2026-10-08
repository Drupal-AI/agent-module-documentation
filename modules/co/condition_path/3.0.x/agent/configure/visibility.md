# Using the Request Path Include Exclude condition

No admin settings page. You configure an **instance** of the condition wherever Drupal exposes Conditions:
most commonly **Block layout → Configure block → Visibility**, where it appears as
**Pages (include and exclude)** (relabeled by `hook_form_block_form_alter`; in non-block contexts such as
Page Manager / Rules it is named **Request Path Include Exclude**).

Plugin id: `request_path_inclexcl` · class `Drupal\condition_path\Plugin\Condition\RequestPathInclexcl`
(extends core `system` `RequestPath`).

## `pages` syntax

One path pattern per line in the *Pages* textarea:

- A plain line = **include** (e.g. `/news`, `/news/*`).
- A line starting with `!` = **exclude** (e.g. `!/news/*/comments`).
- `<front>` targets the front page; `!<front>` excludes it.
- `*` is a wildcard segment (`/news/*`, or `*` for "all pages").
- Both **internal paths and aliases** are matched, **case-insensitively**.

**Validation** (`validateConfigurationForm`): every non-empty line must be `<front>`/`!<front>`, or begin
with `/`, `!/`, `*`, or `!*` — otherwise the form errors ("requires a leading forward slash…").

## Ordering — last matching group wins

`evaluate()` splits the lines and groups *consecutive* include lines and *consecutive* exclude lines into
ordered groups (`groupPages()`), matches each group with core `PathMatcher::matchPath()`, and sets the
result from the **last group that matches**. So order matters: **place more specific paths lower**. Result
is TRUE (visible) when the last matching group is an include group, FALSE when it is an exclude group. An
empty `pages` value evaluates TRUE (always visible). The standard Conditions **Negate** checkbox flips the
outcome.

Worked examples (top-to-bottom):

```
# Show on /news and all subpages, but NOT on comment pages
/news
/news/*
!/news/*/comments

# Show everywhere except news articles, but keep news comment pages visible
*
!/news/*
/news/*/comments

# Front page only
<front>
```

## Where the config lives

Stored on the host object (e.g. the block config entity) under the condition plugin key:

```yaml
visibility:
  request_path_inclexcl:
    id: request_path_inclexcl
    pages: "/news\n/news/*\n!/news/*/comments"
    negate: false
```

Schema: `condition.plugin.request_path_inclexcl` (extends `condition.plugin`) with a single `pages` string.

## Programmatic use

Instantiate via the `condition` plugin manager like any condition:

```php
$condition = \Drupal::service('plugin.manager.condition')
  ->createInstance('request_path_inclexcl', [
    'pages' => "/news\n/news/*\n!/news/*/comments",
  ]);
$visible = $condition->execute(); // applies negate; ->evaluate() is the raw result
```
