# Configuration

Using Wordfilter is a two‑part job: create a **Wordfilter configuration** (your
word list and how it's replaced), then apply that configuration wherever you want
the filtering to happen.

## Step 1 — Create a Wordfilter configuration

1. Log in as a user with the **Administer wordfilter configurations** permission.
2. Go to **Configuration → Content authoring → Wordfilter configurations**
   (`/admin/config/wordfilter_configuration`) and add a configuration.
3. Choose the **Implementation** (the filtering process):
   - **Direct substitution** — matches your words (case‑insensitively, on whole
     words) and replaces them with the substitution text.
   - **Token substitution** — the same, but Drupal tokens inside the substitution
     text are resolved, so you can insert dynamic values like the site name or the
     current user.
4. Add one or more **items**, each with:
   - **Words to filter** — a comma‑ or newline‑separated list of words.
   - **Substitution text** — what matches are replaced with. Leave it empty to
     simply remove the word.
5. Save.

You can create several configurations — for example separate lists for profanity
and for brand normalization — and mix and match where you apply them.

## Step 2 — Apply the configuration

There are three ways to put a configuration to work:

### A. As a text format filter

At **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), edit a text format and enable **Apply filtering
of words**. Then, in that filter's settings, pick the **Active Wordfilter
configurations** to run. Any field using that format is now filtered on output.
You can enable multiple configurations on one format; they run in sequence.

### B. On content types and comment types

When you edit a **content type** (`/admin/structure/types`) or **comment type**
(`/admin/structure/comment`), a **Display settings → Active Wordfilter
configurations** selector is added. Choosing configurations there filters the
rendered node title and body, and the comment subject and body, for that type —
without needing a text format.

### C. In code

Render any string through a text format that has the Wordfilter filter enabled:

```php
$out = [
  '#type' => 'processed_text',
  '#text' => $raw_string,
  '#format' => 'plain_text', // a format with the wordfilter filter enabled
];
```

## Permissions

Wordfilter provides three kinds of permission (at
`/admin/people/permissions`):

- **Administer wordfilter configurations** — *restricted.* Full create, edit, and
  delete access to **all** configurations. Creating a configuration always
  requires this one. Grant it only to trusted administrators.
- **Access wordfilter configurations page** — a non‑restricted permission that
  lets a user view the configurations overview page.
- **Administer wordfilter configuration `<id>`** — a per‑configuration permission
  (one appears for each configuration you create). It lets a user view, edit, and
  delete just that single configuration. This is handy for delegating one word
  list to a specific role.

A note on trust: because substitution text is rendered as admin‑filtered markup,
granting someone a per‑configuration permission effectively lets them author
admin‑filtered HTML on the fields that configuration touches. Grant it
accordingly.

## Extending it

The filtering process is itself a plugin type (`wordfilter_process`), so a
developer can add a custom backend — for example one that calls an external
moderation API — and it will appear as an *Implementation* choice on the
configuration form. See the sibling [`agent/`](../../agent/plugins/process.md)
docs for how to build one.
