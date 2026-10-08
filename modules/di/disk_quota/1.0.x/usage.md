Disk Quota enforces per-user file-storage limits (by role or per user) and blocks uploads that would exceed a user's quota.

---

Disk Quota tracks the total byte size of files a user owns and prevents further uploads once the user's effective limit is reached. Limits are configured per user role on a settings form (Configuration > People > Account settings > Storage Quota) and may be overridden for an individual user on that user's edit form. The effective limit is the per-user override when set, otherwise the highest limit granted by any of the user's roles. Enforcement happens through core's `hook_file_validate()`, so any file saved through a Drupal managed-file/plupload upload is checked; user 1 is exempt. An optional file-type filter limits which files count (images, videos, and/or documents by MIME prefix), and a warning-threshold percentage shows a low-space message before the hard limit. Usage is displayed on the user page via an extra display field, and dynamic per-role "edit role storage quota" permissions let you delegate quota editing. Only files uploaded through Drupal forms are counted; files added out-of-band (FTP, direct filesystem) are not.

---

- Cap total upload storage for authenticated users based on their role (e.g. 50 MB for "authenticated", 5 GB for "premium").
- Give a specific user a larger or smaller quota than their role by setting a per-user override on the user edit page.
- Block a file upload before it is saved when the file would push the user over their storage limit.
- Show a "file too large for remaining space" error that states how much of the quota is already used.
- Warn users with an on-screen message when they cross a configurable percentage (default 70%) of their quota.
- Offer a monetizable "storage plan" model where higher roles map to higher storage limits.
- Track only images toward the quota (e.g. a photo-gallery site) by enabling the "Images" file-type filter.
- Track only videos toward the quota for a media-upload site by enabling the "Videos" filter.
- Count everything that is not an image or video as "documents" and quota only those.
- Count all uploaded files toward the quota by leaving the file-type filter empty (default behavior).
- Display each user's current storage usage and percentage on their user profile page.
- Let users view their own storage usage while hiding it from other non-privileged users, via the "view own storage quota" permission.
- Delegate quota editing for one specific role to a support team using the dynamic "Edit [role] role storage quota" permission.
- Allow site admins with "edit any storage quota" to change any user's per-user override.
- Let users adjust only their own override with "edit own storage quota".
- Exempt the site super-user (user 1) from all quota enforcement automatically.
- Set the warning threshold to a low percentage to nudge users to clean up files early.
- Reset a user's per-user override back to role-based limits by clearing the storage-limit field on their edit form.
- Automatically drop a user's stored quota override when the user account is deleted.
- Enter limits in human-friendly units such as "512", "80 KB" or "50 MB" on the settings and user forms.
- Render the module's README as a formatted help page by also enabling the Markdown filter module.
- Provide storage governance on multi-tenant or membership sites where each account has an allotment.
