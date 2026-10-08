<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Exclude-pages syntax

The module does **not** add any new field or setting. You use the existing core **Pages**
block-visibility condition (the "Pages" textarea under a block's *Visibility* settings), and
gain one extra piece of syntax: a leading `!` marks an **exclude** pattern.

## Where you type it

- UI: **Admin → Structure → Block layout** → *Configure* a block → *Pages* visibility →
  the **Pages** textarea. One path per line.
- Config entity: `block.block.<id>` → `visibility.request_path.pages` (a newline-separated
  string).

Two radios accompany the textarea (core behaviour, unchanged):

- **Show for the listed pages** — `negate: false` (the default).
- **Hide for the listed pages** — `negate: true`.

## The rules

- Every line is a path pattern. It **must** begin with `/`, or with `!/`, or be `<front>` /
  `!<front>` (validation rejects anything else, e.g. a bare `user/*`).
- `*` is a wildcard segment, exactly as in core.
- A line **without** `!` is an **include** pattern.
- A line **prefixed with `!`** is an **exclude** pattern; the rest of the line (after the `!`)
  is matched like any other pattern and may itself contain `*`.
- **Order matters** — lines are read top to bottom and the last matching decision wins, so an
  include line placed *after* an exclude can re-add a page (and vice-versa).
- Matching is case-insensitive and runs against **both** the URL alias and the internal path.

## Worked example

With **Show for the listed pages** selected and this Pages value:

```
/user/*
!/user/jc
!/user/jc/*
```

the block shows on all user pages **except** `/user/jc` and everything beneath it. Flip to
**Hide for the listed pages** and the same list *hides* everywhere under `/user/*` but the
`!` lines *show* it again on `/user/jc` and its children (the exclusion inverts within the
negated context).

Re-include a page carved out by a wildcard by ordering the include after the exclude:

```
!/order/*/*
/order/*/complete
```

shows the block only on `/order/*/complete` while hiding the other `/order/*/*` pages.
(The reverse order does **not** re-hide — see the mechanism doc for why:
[../plugins/request-path-override.md](../plugins/request-path-override.md).)

`<front>` (and `!<front>`) target the site front page.
