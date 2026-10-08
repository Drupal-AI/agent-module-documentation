# Configuration

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to `admin/config/carryquery` (route `carryquery.config`).

## Choose which parameters to carry

Add the **query-parameter key(s)** that should be carried forward to subsequent
pages. For example, adding `utm_source` means that value will be preserved and made
available as a token as the visitor navigates. Parameters are read from the current
request's query string. Save the form when done.

## Using the link tokens

Query carry exposes the carried values as tokens, which you can use anywhere tokens
are supported (via Token Filter, they also work inside filtered text formats).

Note that links added directly in the CKEditor WYSIWYG are **not** processed by this
module. To place a link the module can process, use its link tokens instead, in
either of two forms:

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
with a pipe (`|`). The module renders these into HTML anchors with the carried query
parameters appended.

## A note on output safety

Token output is rendered through Token Filter's sanitization, so carried values are
filtered where they are output. There are no external services or network calls, and
the only endpoint the module adds is this admin settings form.
