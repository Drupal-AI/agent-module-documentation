Tagify User List is a submodule of Tagify that adds a user-reference widget rendering each user as a Tagify tag with an avatar and info label.

---

Referencing users (assignees, members, authors, mentions) benefits from more context than a plain autocomplete gives. Tagify User List provides a dedicated field widget, `tagify_user_list_entity_reference_autocomplete_widget`, styled after Tagify's "users list" example. Each suggestion and each selected tag shows the user's avatar image alongside their name and an info label (by default `[user:mail]`). The widget is configurable per field: match operator (defaults to starts-with), maximum suggestions, placeholder, the avatar image field to use (default `user_picture`), the image style (default `thumbnail`), and whether to show the info label and entity ID. It ships a `UserImageResolver` service to locate the right avatar field/style and an autocomplete matcher that extends the parent Tagify matcher. A signed-hash autocomplete route mirrors core's entity-reference security model. Developers can adjust results with `hook_tagify_user_list_autocomplete_matches_alter()`. It requires the parent Tagify module.

---

- Build a user picker that shows each person's avatar.
- Assign tasks or content to users with a visual chip UI.
- Show a user's email as an info label beside each suggestion.
- Reference site members with removable avatar tags.
- Configure which image field supplies the avatar (e.g. `user_picture`).
- Pick the image style used for avatars (e.g. `thumbnail`).
- Default to starts-with matching for large user bases (performance).
- Limit the number of user suggestions shown.
- Add placeholder text prompting who to search for.
- Fall back to a default avatar for users without a picture.
- Provide a mentions-style user selector in content forms.
- Populate a "reviewers" or "watchers" field with avatars.
- Show or hide the user entity ID within the tag.
- Customize the info label with any user token.
- Alter or filter matched users via a hook in custom code.
- Reuse the user-list autocomplete route for a custom form.
- Give an editorial workflow a friendly people-picker.
- Select multiple users respecting field cardinality.
- Keep user selection consistent with other Tagify fields.
- Style the widget to match Claro or Gin admin themes.
