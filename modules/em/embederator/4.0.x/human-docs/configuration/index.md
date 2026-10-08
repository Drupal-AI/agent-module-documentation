# Configuration

Setting up an embed is a two‑step job: first create an **embed type** (the
reusable template), then create one or more **embeds** (the instances) and place
them on your content.

## Step 1 — Create an embed type

Go to **Structure → Embederator types** (`/admin/structure/embederator_type`) and
add a type. This is where the shared markup lives, so you need the *Administer
embederator types* permission — grant it only to trusted site builders, because
the markup is rendered without filtering (see the security note below).

An embed type has these settings:

- **Label** and **description** — how the type is identified in the admin UI.
- **Embed markup** — a rich‑text field holding the HTML skeleton for the embed
  (the shared `<script>`, `<iframe>` or widget code). Put tokens where the
  per‑instance values should go, for example `[embederator:embed_id]`.
- **Use server‑side include (SSI)** — when ticked, the type ignores the pasted
  markup and instead fetches an **embed URL** on the server, inlining whatever
  that URL returns. Use this to pull in an external HTML fragment by address
  rather than pasting client‑side code. The URL can contain tokens too.
- **Wrapper class** — one or more CSS classes added to the wrapper element around
  the embed, handy for responsive theming.

### Tokens

Anywhere in the markup or the SSI URL you can reference an embed's field values
with `[embederator:<field>]`. Out of the box every embed has an **Embed ID**
field (`embed_id`), so `[embederator:embed_id]` is the most common token. If you
add more fields to the type (see below), each becomes an additional token. Token
values supplied by editors are HTML‑escaped when inserted, so editors filling in
tokens cannot inject markup.

### Adding fields to a type

An embed type is fieldable. Beyond the built‑in Embed ID you can add your own
fields — a campaign code, a date, a second ID — through the type's *Manage
fields* screen, and then reference them as extra tokens in the markup.

## Step 2 — Create an embed

Go to **Content → Embederators** (`/admin/content/embederator`) and add an embed
of the type you created. Fill in its **Label**, its **Embed ID**, and any extra
fields you added. Each embed is a normal content entity, so it has its own page at
`/embederator/{id}` and appears in the browsable admin list. The add/edit form
shows a live preview with the tokens highlighted, and can parse tokens out of a
freshly pasted embed snippet for you.

## Choosing how an embed loads (the field formatter)

When you display an embed's **Embed ID** field — on the embed's own view mode or
wherever you reference it — the `Embederator` formatter offers four **load
styles**:

- **Direct** — the embed markup is rendered straight into the page.
- **Lazy** — the markup is swapped in with JavaScript after the page has loaded,
  so a heavy embed does not block the initial render.
- **Lazy unless query params** — lazy‑loads, except when the page URL carries
  query parameters (useful so tracked landing URLs render the embed immediately).
- **Iframe proxy** — renders the embed inside a self‑resizing iframe (using the
  bundled iframeResizer library) so its CSS and JavaScript are isolated from the
  host page. You can set an **initial height** for the iframe.

Two extra formatter options help with edge cases: **append a unique ID** rewrites
form‑input DOM IDs so the same embed can appear twice on one page without
colliding, and **nullify cache** forces the embed's output never to be cached
when its third‑party markup must always be fresh.

## Permissions

- **Administer embederator types** — create and edit embed types, i.e. author the
  raw markup. This is the sensitive one.
- **View / Add / Edit / Delete embederator entity** — manage the individual
  embeds. Safe to grant to content editors, since they only supply token values.

## A security note worth knowing

The embed **type's** markup is always rendered as full HTML with no filtering,
regardless of the text format you pick on the field. That is intentional — embeds
often need raw `<script>` — but it means anyone who can administer embed types can
store code that runs for every visitor. Treat *Administer embederator types* as a
code‑level trust boundary and grant it only to people you would trust with the
theme or with custom modules. Editors who merely fill in token values on embeds
are safe, because those values are escaped.
