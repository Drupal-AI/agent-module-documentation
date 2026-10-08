# Configuration

The settings page controls the title of every clone, its publication status,
and which fields are copied. You can leave the defaults in place and start
cloning immediately, but it is worth understanding each option first.

To reach the settings you need the **Administer Quick Node Clone Settings**
permission (see [Installation](../installation/index.md)).

## Open the settings page

1. Go to **Configuration → Quick Node Clone Setting**
   (`/admin/config/quick-node-clone`).
2. You land on the **Node** tab. A second **Paragraph** tab holds the same kind
   of field-exclusion list for paragraph types.

![The Quick Node Clone Setting page with the Node tab selected](../images/settings.png)

## Set the cloned-node title prefix

1. In **Text to prepend to title**, enter the text you want added to the front
   of every cloned node's title. The default is **Clone of**.
2. A space is automatically added between this text and the original title — so
   cloning a node called *Weekly Newsletter* with the default produces
   *Clone of Weekly Newsletter*. Leave the field empty if you want clones to
   keep the exact original title.

## Choose the publication status of clones

Under **Publication status**, pick what state a freshly cloned node should be in:

- **Default – Node type default** — use the content type's own default published
  setting (this is selected out of the box).
- **Original – Clone will have the same status as the original** — the clone
  matches whether the source node was published or not.
- **Published** — always create the clone published.
- **Unpublished** — always create the clone as an unpublished draft.

## Create group relationships (optional)

**Create group relationships?** only matters when the contrib **Group** module
is installed. When ticked, the source node's group relationships are recreated
on the clone. It has no effect if Group is not enabled.

## Choose which fields to exclude from the clone

By default a clone copies every field. Use the **Exclusion list** to skip fields
you never want carried over (for example an internal reference number that must
be unique per node):

1. Under **Entity Types**, tick the content type(s) you want to configure —
   *Article*, *Basic page*, and so on. The list reflects the content types on
   your site.
2. When you select a type, the **Fields** section below refreshes to show that
   type's fields. Tick any field you want **excluded** from the clone. Until you
   select a content type, the Fields area reads *No content types selected*.
3. To exclude fields on referenced **paragraphs**, switch to the **Paragraph**
   tab and repeat the same steps for the relevant paragraph types.

## Save

Click **Save configuration** at the bottom. Your changes apply to every clone
created from that point on.

## Clone a node

Configuration done, editors duplicate content from the node itself:

1. Open the node you want to duplicate (it must be of a content type the
   editor's role has a **Clone _<type>_ content** or **Clone own _<type>_
   content** permission for — see [Installation](../installation/index.md)).
2. Click the **Clone** tab / operation. Quick Node Clone opens the *add content*
   form pre-filled with a deep copy of the node's field values — with the title
   prefix applied and any excluded fields left blank.
3. Adjust whatever you need, then **Save**. This creates a brand-new node;
   referenced Paragraphs are copied too, so editing the clone never touches the
   original.
