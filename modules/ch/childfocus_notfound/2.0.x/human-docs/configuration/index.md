# Configuration

Setting up Childfocus takes two steps: entering your notfound.org key, and placing
the block so it shows on the 404 page.

## 1. Get your notfound.org key

1. Go to [notfound.org](https://notfound.org/) and sign up / register your site.
2. They give you an **embed code**. Copy the **key** out of that embed code — that
   short value is what this module needs.

> Note from the project: the maintainers had hoped Child Focus would provide an
> automatic key generator, but that hasn't happened, so you do need to obtain the
> key yourself from notfound.org.

## 2. Enter the key

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Childfocus (notfound.org)**, or navigate directly to
   `/admin/config/childfocus_notfound`.
3. Paste your key into the key field and **Save configuration**.

## 3. Place the block on the 404 page

The appeal is a block, so you place it through the normal Block layout UI:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. In the region where you want the appeal to appear — typically the **Content**
   region of your theme — click **Place block** and choose the **Childfocus
   (notfound.org)** block.
3. In the block's configuration, open the **Childfocus (notfound.org)** visibility
   tab and tick **Show in page not found**. This restricts the block to 404
   responses, so it appears only on the "page not found" screen rather than on
   every page.
4. **Save block.**

## Verify it worked

Visit a URL that doesn't exist on your site (for example
`/this-page-does-not-exist`) to trigger a 404. The Childfocus appeal should render
in the region you chose. If it doesn't appear, re-check that the key is saved and
that the block's "Show in page not found" visibility condition is enabled.

## A note on privacy

Because the block loads content from notfound.org, it introduces a third-party
request into your 404 page. If your site has a cookie/consent policy that covers
embedded third-party content, include this widget in that review.
