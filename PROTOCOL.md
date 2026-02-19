SOVEREIGNTY IDENTITY STACK v1.6
Status Frozen | Type SSH-Ed25519 | Node 01

1. Mandate
Identity = hardware-bound cryptographic signature.
Verified by deterministic DNS pulse.

2. DNS Schema
_identity TXT:
v=1.5; epoch=[int]; status=[active|revoked]; alg=ssh-ed25519; fp=SHA256:[hash]; activated=[date]; prev=[hash]

Rules
- Order irrelevant; verifiers parse map.
- Precedence: DNS > IDENTITY.json.
- Rollback: require new_epoch >= last_seen_epoch.

3. Validation
Valid IFF:
1. status=active (no resolve = invalid)
2. DNS fp == Git commit fp
3. Ed25519 signature valid

4. Dependencies
- Registrar = physical trust root (loss = identity death)
- Time: Git timestamps advisory; DNS activated = logical root

Infrastructure > Platform.
