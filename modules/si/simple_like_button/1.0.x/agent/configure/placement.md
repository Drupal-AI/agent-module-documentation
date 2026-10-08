<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Placing and operating the Simple Like Button

## Place the block
1. Go to **Administration → Structure → Block layout** (Block UI).
2. Place **Simple Like Button** in a region (e.g. Content) on the theme.
3. Use the block's **Visibility** settings to limit it to the pages/entity types where a like
   button makes sense (it only renders on pages whose route carries an entity, and only for
   authenticated users).

## How it behaves
- The button shows `Like · N` / `Liked · N` for the current entity and, when there are likes,
  a `Liked by:` username list with a `You,` marker for the current user.
- Clicking submits over AJAX (`LikeForm::submitLikeAjax`):
  - no existing row for this user+entity → creates a `simple_like` entity (owner = current user);
  - existing row → deletes it (unlike).
- The count and styling update client-side; messages are cleared so nothing leaks on refresh.

## Data model
Likes are `simple_like` content entities in the `simple_like` table with columns
`entity`, `entity_id`, `bundle`, `user_id`, `status`. Query these for per-entity totals.

## Permissions / access
- Liking is available to any **authenticated** user; anonymous users see no button.
- `administer like entities` is the entity admin permission.
- Submissions are CSRF-protected by Drupal's form token (standard `FormBase`).
- Styling comes from the `simple_like_button/like` asset library.
