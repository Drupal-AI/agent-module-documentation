# Configuration

Solo Copy Blocks is driven by a single action page. There are no ongoing settings
to tune — you visit the page and run the copy once, when you are ready to move
your blocks into the Solo theme.

## Before you start

1. Make sure the **Solo** theme is installed (see
   [Installation](../installation/index.md)). It does not need to be your default
   theme.
2. Make sure your existing blocks are placed in the **W3CSS** theme or one of its
   sub-themes — that is the source the module reads from.

## Run the copy

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Copy Blocks to Solo Theme**, or navigate
   directly to `/admin/config/system/solo-copy-blocks`.
3. Click the **Copy Blocks** button to start the migration.

The module then copies each block placement from the source theme into Solo,
keeping the block order and weight, preserving whether each block is enabled or
disabled, and mapping the source theme's regions onto Solo's regions
automatically.

## After running it

Because this tool **duplicates configuration**, run it deliberately and check the
outcome. Switch to (or preview) the Solo theme and review the block layout:
confirm the blocks landed in the regions you expected, that their order looks
right, and that any blocks you wanted disabled stayed disabled. If something is
off you can adjust it on Drupal's normal **Block layout** page for the Solo theme.
