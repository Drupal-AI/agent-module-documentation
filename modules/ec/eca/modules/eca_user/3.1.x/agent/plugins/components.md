# eca_user plugins

Registers into ECA Core managers. Config schema: `config/schema/eca_user.schema.yml`.

**Events** (`UserEvent`, derived): user login, logout, register/insert, update, cancel, etc.

**Conditions** (`src/Plugin/ECA/Condition`): `CurrentUserId`, `CurrentUserRole`,
`CurrentUserPermission`, `UserId`, `UserRole`, `UserPermission` (bases `BaseUser`, `UserTrait`).

**Actions** (`src/Plugin/Action`): `LoadCurrentUser`, `NewUser`, `SwitchAccount`,
`SwitchServiceAccount`, `SwitchBack`, `GetPreferredLangcode`.

`SwitchAccount` / `SwitchServiceAccount` change the acting user for subsequent steps; always
pair with `SwitchBack` to restore.
