# Configuration

Slots needs a short setup before content appears. There are three steps: place a
slot, add the Slots field to a block type, then create content that targets the
slot. Make sure the submodule matching your integration is enabled first
(`slots_paragraphs`, `slots_views`, or `slots_twig`) — see
[Installation](../installation/index.md).

## 1. Place a slot

A slot has two things: an **identifier** (a reusable name — it does not have to
be unique) and a **cardinality** (the maximum number of blocks it will render).
Place the slot in whichever context you need:

- **Block UI** — add the "Slot block" block to a region under **Block layout**.
- **Layout Builder** — use the injected **"+ Add slot"** create link that
  appears on the choose-block screen.
- **Views** — add a "Slot" to the view's header or footer (requires
  `slots_views`).
- **Paragraphs** — add a slot inside a Paragraph (requires `slots_paragraphs`).
- **Twig** — call `{{ slot(slot_id, cardinality) }}` in a template (requires
  `slots_twig`).

Render the page containing the slot in the browser **at least once** so the slot
is registered.

## 2. Add the Slots field to a block type

Go to **Structure → Block content types**
(`/admin/structure/block-content`), pick the block type you want to use as slot
content, open **Manage fields**, and add a field of type **Slots**.

## 3. Create the slot content

Go to **Content → Blocks** (`/admin/content/block`) → **Add content block**:

1. Fill in the block's normal fields.
2. In the **Slots** fieldset, check **"This content shall be displayed in
   slots"**.
3. Configure the **conditions**, including a **Slot** condition whose identifier
   matches the slot you placed in step 1. You can combine it with any other
   condition — request path, language, role, and so on.
4. **Save.** The block now renders in every matching slot.

Behind the scenes the module evaluates each block's conditions against the
current request, loads the matching blocks, renders them, and caches the result
for performance. When several blocks compete for the same slot, drag-and-drop
weight ordering decides their order, and the slot's cardinality caps how many
actually render.

## Managing slots and permissions

Existing slot entities are managed at **Content → Slots**
(`/admin/content/slots`). Access is split across four permissions so you can
grant only what each role needs:

- **`administer slots`** — manage slot entities. Treat this as a restricted,
  trusted permission.
- **`access slot library`** — view the slot overview page.
- **`view slot identifiers`** — surface where slots exist on the page and how to
  interact with them.
- **`create slots`** — create new slot IDs from the UI integrations.

## Swapping content later

The big payoff: because slot content lives in content blocks rather than in
exported configuration, editors can change or replace what fills a slot at any
time through the UI — no configuration redeploy required.
