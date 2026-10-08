# Configuration

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to `admin/config/carryquery` (route `carryquery.config`).

## Choose which parameters to carry

In **Query carry forward configuration**, add the **query-parameter key(s)** that
should be carried forward to subsequent pages — **one key per line**. For example,
adding `utm_source` means that value will be preserved as the visitor navigates.
Only keys listed here are carried, and they are read from the current request's query
string. Save the form when done.

## Server-side vs. JavaScript mode

- **Server-side (default):** leave **Add via javascript** unchecked. The module's
  outbound path processor appends the configured parameters to the internal URLs
  Drupal generates, and GET-method forms receive them as hidden fields.
- **JavaScript:** check **Add via javascript** to instead append the parameters to
  same-site links *after* the page has rendered. In this mode the server-side path
  processor stands down and the bundled JavaScript does the work.

## Using the link tokens

Query carry exposes link tokens you can use anywhere tokens are supported (via Token
Filter, they also work inside filtered text formats).

Note that links added directly in the CKEditor WYSIWYG are **not** rewritten by the
server-side processor. To place a link the module can process, use its link tokens
instead, in either of two forms:

```
[link:route:<route.name>,id=,class=,text=]
[link:path:<internal/path>,id=,class=,text=]
```

For example:

```
[link:route:system.admin,id=myid,text=mandatory text that appears in the a tag,class=myclass1|myclass2]
[link:path:admin/content,id=myid,text=mandatory text that appears in the a tag,class=myclass1|myclass2]
```

The `text=` part is the mandatory visible link text. Separate multiple CSS classes
with a pipe (`|`). The module renders these into HTML anchors.

## A note on output safety

Carried values are URL-encoded where they appear in generated link URLs and
HTML-escaped where they appear in hidden form fields, and the module adds the
`url.query_args` cache context so per-request parameters are not mixed between
visitors. There are no external services or network calls, and the only endpoint the
module adds is this admin settings form.
