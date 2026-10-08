# H5P permissions

Most are `restrict access: TRUE` (trusted users only).

| Permission | Gates |
|---|---|
| `administer h5p libraries` | Upload, update, delete and restrict libraries on the H5P Content page (`/admin/content/h5p`). |
| `update h5p libraries` | Update existing H5P libraries (trusted users only). |
| `access all h5p results` | View H5P result data for all users (used by the results views access plugin). |
| `access own h5p results` | View one's own H5P results from the user profile. |
| `create restricted h5p content types` | Create content of content types marked "restricted" in the library admin UI. |
| `copy all h5ps` / `copy own h5ps` | Show the Copy button for all H5Ps / only ones the user can edit. |
| `download all h5ps` / `download own h5ps` | Show the Download button for all / own H5Ps (no effect if download is globally disabled). |
| `embed all h5ps` / `embed own h5ps` | Show the Embed button for all / own H5Ps (no effect if embed is globally disabled). |

The **h5peditor** submodule adds `access h5p editor` (use the authoring widget) and
`install recommended h5p libraries` (install only Hub-recommended content types).

Note: the settings form itself is gated by core's `administer site configuration`, not an H5P
permission.
