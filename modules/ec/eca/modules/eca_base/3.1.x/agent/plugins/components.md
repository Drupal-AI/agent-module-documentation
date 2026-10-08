# eca_base plugins

All register into ECA Core managers (`src/Plugin/ECA/Event`, `.../Condition`,
`src/Plugin/Action`).

**Events** (`BaseEvent`, derived): cron-scheduled event and a custom (triggerable) event.

**Conditions**: `ScalarComparison`, `ListContains`, `ListCountComparison`, `TokenExists`,
`EcaState`.

**Actions** (selected, `src/Plugin/Action`):
- Tokens: `TokenSetValue`, `TokenSetRandomValue`, `TokenReplace`, `TokenSetContext`.
- State: `EcaStateRead`, `EcaStateWrite`.
- Key-value: `KeyValueStoreRead/Write/Delete`, `KeyValueExpirableStoreRead/Write/Delete`.
- Temp store: `PrivateTempStoreRead/Write/Delete`, `SharedTempStoreRead/Write/Delete`.
- Lists: `ListAdd`, `ListRemove`, `ListMerge`, `ListSort`, `ListCount`, `ListCompare`,
  `ListSaveData`, `ListDeleteData`.
- Misc: `LockAcquire`, `Translate`, `SetEcaLogLevel`, `WarningMessage`, `ErrorMessage`,
  `TriggerCustomEvent`, `VoidForAndCondition`.

To add your own, put plugins in your module (see the eca core plugins doc for attributes) — no
config here beyond `config/schema/eca_base.schema.yml`.
