Require Import prelude.

Section proof.
Context `{hG: heapGS Σ, !ffi_semantics _ _, !goGlobalsGS Σ}.

Definition is_Raft (rf : loc) : iProp Σ :=
  "#Hinv" ∷ is_Mutex (struct.field_ref_f demo.Raft "mu" rf) (
      ∃ (currentTerm : w64),
        "Hcur" ∷ rf ↦s[demo.Raft :: "currentTerm"] currentTerm
    ) ∗
  "_" ∷ emp.

Lemma AppendEntries_spec rf (newTerm : w64) :
  ❴ is_pkg_init demo ∗ is_Raft rf ❵
    rf@"demo"@"Raft'ptr"@"AppendEntries" #newTerm
  ❴ returns (); True ❵.
Proof.
  wp_start. iNamed "Hpre".
  wp_auto.
  wp_apply (wp_Mutex__Lock with "[$Hinv]");
    iIntros "[Hl HlockInv]"; iNamed "HlockInv".
  wp_auto.
  rewrite bool_decide_decide; destruct decide.
  - (* newTerm > currentTerm *)
    wp_auto.
    wp_apply (wp_Mutex__Unlock with
               "[$Hinv $Hl Hcur]").
    {
      iFrame.
    }
    iApply "HΦ". done.
  - (* ¬(newTerm > currentTerm) *)
    wp_auto.
    wp_apply (wp_Mutex__Unlock with
               "[$Hinv $Hl Hcur]").
    {
      iFrame.
    }
    iApply "HΦ". done.
Qed.

Lemma test_spec rf (newTerm : w64) :
  ❴ is_pkg_init demo ∗ is_Raft rf ❵
    rf @ "demo" @ "Raft'ptr" @ "test" #()
  ❴ returns (); True ❵.
Proof.
  wp_start as "#Hrf". wp_auto.
  iPersist "rf".
  wp_apply primitive.wp_fork.
  {
    wp_apply (AppendEntries_spec with "[$Hrf]").
    done.
  }
  wp_apply primitive.wp_fork.
  {
    wp_apply (AppendEntries_spec with "[$Hrf]").
    done.
  }
  by iApply "HΦ".
Qed.

Lemma BadAppendEntries_spec rf (newTerm : w64) :
  ❴ is_pkg_init demo ∗ is_Raft rf ❵
    rf @ "demo" @ "Raft'ptr" @ "Bad" #newTerm
  ❴ returns (); True ❵.
Proof.
  wp_start. iNamed "Hpre".
  wp_auto.
Abort.

End proof.
