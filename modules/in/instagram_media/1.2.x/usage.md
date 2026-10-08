Instagram Media displays a business or creator account's recent Instagram posts inside a Drupal block. It pulls posts from the Facebook Graph API with a long-lived access token, downloads each image or video to the site's public files, and renders the feed with configurable image styles, grid layouts, captions, insight counts, a profile header, and optional Swiper carousel or Fancybox lightbox.

---

Everything is configured per block instance in Block layout — there is no global settings page. Placing the "Instagram Media Block" and pasting a long-lived token is enough to start; the block save triggers the first fetch, and thereafter cron re-fetches on each run (purging and rebuilding the local media and the cached `instagram_media_posts` / `instagram_media_links` tables). Optional auto-refresh keeps the token alive by exchanging it via the Graph API when an App ID and App Secret are supplied. Because rendering is served entirely from the locally cached data and downloaded files, the feed stays fast and does not call Instagram on every page view. The module targets the current Graph API (v22.0) rather than the deprecated Basic Display API, so it needs a business/creator account linked to a Facebook Page and an appropriately scoped token.

---

- Show a brand's recent Instagram posts on the homepage.
- Add a social feed block to a site footer.
- Display an Instagram grid on a marketing landing page.
- Give a campaign page social proof with live posts.
- Place the feed in any theme region via Block layout.
- Render posts through a chosen image style.
- Serve responsive images for the feed (with Responsive Image module).
- Apply a different image style to individual posts.
- Limit the feed to the N most recent posts (up to 25).
- Hide videos and show their thumbnails instead.
- Autoplay Instagram videos inline in the feed.
- Show post captions under each item.
- Show like and comment counts (insights) per post.
- Display a profile header with avatar, username, and follower stats.
- Turn the feed into a Swiper carousel with arrows and pagination.
- Open media in a Fancybox lightbox.
- Choose a responsive grid layout from mobile to desktop.
- Disable the module CSS to apply fully custom styling.
- Keep the feed current automatically on cron.
- Auto-renew the access token before it expires.
- Show a photographer's or venue's latest work.
- Drive traffic to a linked Instagram account.
- Alter the block render array from another module via the build alter hook.
