# Configuration

All of Floating Block's behavior is controlled from one admin form. Until you add
at least one line here, the module does nothing on the front end.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default — this module adds no permission of its own).
2. Go to **Configuration → User interface → Floating Block**, or navigate
   directly to `/admin/config/user-interface/floating-block`.

## The form fields

- **Floating block settings** — a textarea where you list **one floating block
  per line**. Each line names an element to pin and, optionally, some tuning
  options (see the line syntax below).
- **Min width** — a viewport width, in pixels, *below* which floating is turned
  off. This is how you stop a sidebar from floating on narrow phone screens where
  it would get in the way. Set it to `0` to keep blocks floating at every screen
  size.

Click **Save configuration** and the change takes effect immediately — the
module marks its settings as a cacheable dependency, so you do not need to clear
caches for edits to appear.

## The line syntax

Each line in the textarea follows this pattern:

```
selector|key=value,key=value,...
```

- The part **before** the `|` is the element to float — any valid jQuery/CSS
  selector (an id such as `#sidebar-left`, a class such as `.toc`, etc.).
- The part **after** the `|` is an optional, comma‑separated list of options for
  that element. The `|` and options can be omitted entirely if you just want the
  element to float with defaults.

Examples:

| Line | What it does |
|------|--------------|
| `#sidebar-left` | Floats the element matched by `#sidebar-left` with default behavior. |
| `#sidebar-left\|padding_top=8,padding_bottom=4` | Floats it, but keeps it 8px from the top of the viewport while floating and 4px from the bottom when it nears the end of the page. |
| `#sidebar-left\|container=#main` | Floats it but keeps it constrained within the `#main` wrapper, so it never drifts outside that column. |

You can list several lines to float multiple regions at once.

## The per‑block options

- **`padding_top`** — pixels of offset from the top of the viewport while the
  element is floating. Use this to clear a sticky header.
- **`padding_bottom`** — pixels of offset from the bottom of the page, so the
  floating element stops short of the footer.
- **`container`** — a selector for a wrapper element; the floating element is kept
  inside it and won't overlap other regions such as the footer.

Other `key=value` pairs you add are stored and passed through to the JavaScript
as well, but the three above are the ones the module documents.

## Validation

When you save, the form round‑trips your text (text → stored array → text again)
and rejects any line whose syntax is malformed — that is, any line that does not
cleanly match the `selector|key=value,...` pattern. If you get a validation
error on the *Floating block settings* field, check that each line follows the
format exactly.
