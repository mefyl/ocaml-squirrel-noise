(* Limited smoke test as we don't have a reference implementation. *)

let int32_1d () =
  let seed = 42l in
  let check exp v =
    let noise = Squirrel_noise.Int32.noise_1d ~seed v in
    assert (Int32.equal noise exp)
  in
  check 646027826l 0l

let () = int32_1d ()
