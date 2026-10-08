Profile provides configurable, fieldable user profile entities — define profile types (like "Address" or "Membership"), attach fields, and let each user own one or many of them separately from the core user account.

---

Profile adds a dedicated `profile` content entity and a `profile_type` config-entity bundle, so administrators can create any number of profile types at Admin → Configuration → People → Profile types and attach arbitrary fields to each. Unlike putting fields directly on the user, profiles are separate, individually revisionable, and can be single (one per user) or multiple (e.g. several addresses per user). A profile type can auto-appear on the registration form, be limited to specific roles, support revisions, and expose a display label. Each user gets tabs/pages under `/user/{user}/{profile_type}` to view, add, edit, and set a default profile, with access governed by the Entity API module's per-bundle permissions (view/update/delete own or any) plus a role-restriction check baked into the access handler. The module integrates with Views (relationships and current-user/owner argument defaults), provides an entity-reference selection handler and a profile form field widget for embedding a profile inside another entity's form, offers a Search API processor for indexing, and ships migrate source plugins for importing legacy profile data. Programmatic helpers on the profile storage load a user's profiles or their default, and a user-syncer service keeps single-profile data attached to accounts. It depends on core Field/User/Views and the contrib Entity API module.

---

- Create an "Address" profile type with address fields separate from the user account.
- Let users store multiple shipping/billing addresses via a multiple profile type.
- Add a "Membership" profile with tier, join date, and status fields.
- Collect extra registration data by showing a profile type on the signup form.
- Restrict a profile type (e.g. "Staff") to specific roles.
- Keep revisions of a user's profile changes over time.
- Set one profile as the user's default among several.
- Expose profile fields in Views via the profile relationship.
- Filter a View to the current user's profile with an argument default.
- Reference a user's profile from another entity via the profile selection handler.
- Embed a profile edit form inside another form with the profile form widget.
- Index profile field data in Search API for site search.
- Grant "view own"/"view any" access per profile type via entity permissions.
- Let users edit only their own profile while admins manage all.
- Store arbitrary key/value data on a profile via `getData()`/`setData()`.
- Load a user's profile of a type programmatically (`loadByUser`).
- Load a user's default profile of a type (`loadDefaultByUser`).
- Load all of a user's profiles of a type (`loadMultipleByUser`).
- Migrate Drupal 6/7 profile data using the provided migrate source plugins.
- Theme profiles with `profile.html.twig` and view modes.
- Provide public "member profile" pages built from selected fields.
- Compare or copy field values between two profiles (`equalToProfile`/`populateFromProfile`).
- Publish/unpublish profiles in bulk with the provided actions.
- Separate sensitive user data into a role-restricted profile type.
- Build a directory/listing of users by profile fields via Views.
