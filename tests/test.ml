module Cxx = struct
  module Int32 = struct
    external noise_1d : int32 -> int32 -> int32 = "int32_noise_1d"

    external noise_2d : int32 -> int32 -> int32 -> int32 = "int32_noise_2d"

    external noise_3d :
      int32 -> int32 -> int32 -> int32 -> int32
      = "int32_noise_3d"

    external noise_4d :
      int32 -> int32 -> int32 -> int32 -> int32 -> int32
      = "int32_noise_4d"
  end

  module ZeroToOne = struct
    external noise_1d : int32 -> int32 -> float = "zero_to_one_noise_1d"
  end

  module NegOneToOne = struct
    external noise_1d : int32 -> int32 -> float = "neg_one_to_one_noise_1d"
  end
end

let int32_1d () =
  let seed = 42l in
  let check v =
    let noise = Squirrel_noise.Int32.noise_1d ~seed v in
    let () =
      Alcotest.(check int32)
        (Printf.sprintf "1D %ld" v)
        (Cxx.Int32.noise_1d seed v)
        noise
    in
    noise
  in
  let noise = check 0l in
  let noise = check noise in
  check noise |> ignore

let int32_2d () =
  let seed = 42l in
  let check x y =
    let noise = Squirrel_noise.Int32.noise_2d ~seed x y in
    let () =
      Alcotest.(check int32)
        (Printf.sprintf "2D %ld %ld" x y)
        (Cxx.Int32.noise_2d seed x y)
        noise
    in
    ( Squirrel_noise.Int32.noise_1d ~seed noise
    , Squirrel_noise.Int32.noise_1d ~seed (Int32.add noise 1l) )
  in
  let x, y = check 0l 0l in
  let x, y = check x y in
  check x y |> ignore

let int32_3d () =
  let seed = 42l in
  let check x y z =
    let noise = Squirrel_noise.Int32.noise_3d ~seed x y z in
    let () =
      Alcotest.(check int32)
        (Printf.sprintf "3D %ld %ld %ld" x y z)
        (Cxx.Int32.noise_3d seed x y z)
        noise
    in
    ( Squirrel_noise.Int32.noise_1d ~seed noise
    , Squirrel_noise.Int32.noise_1d ~seed (Int32.add noise 1l)
    , Squirrel_noise.Int32.noise_1d ~seed (Int32.add noise 2l) )
  in
  let x, y, z = check 0l 0l 0l in
  let x, y, z = check x y z in
  check x y z |> ignore

let int32_4d () =
  let seed = 42l in
  let check x y z t =
    let noise = Squirrel_noise.Int32.noise_4d ~seed x y z t in
    let () =
      Alcotest.(check int32)
        (Printf.sprintf "4D %ld %ld %ld %ld" x y z t)
        (Cxx.Int32.noise_4d seed x y z t)
        noise
    in
    ( Squirrel_noise.Int32.noise_1d ~seed noise
    , Squirrel_noise.Int32.noise_1d ~seed (Int32.add noise 1l)
    , Squirrel_noise.Int32.noise_1d ~seed (Int32.add noise 2l)
    , Squirrel_noise.Int32.noise_1d ~seed (Int32.add noise 3l) )
  in
  let x, y, z, t = check 0l 0l 0l 0l in
  let x, y, z, t = check x y z t in
  check x y z t |> ignore

let zero_to_one_1d () =
  let seed = 42l in
  let check v =
    let noise = Squirrel_noise.ZeroToOne.noise_1d ~seed v in
    Alcotest.(check @@ float 0.00001)
      (Printf.sprintf "1D %ld" v)
      (Cxx.ZeroToOne.noise_1d seed v)
      noise
  in
  let () = check 0l and () = check 42l and () = check 666l in
  ()

let neg_one_to_one_1d () =
  let seed = 42l in
  let check v =
    let noise = Squirrel_noise.NegOneToOne.noise_1d ~seed v in
    Alcotest.(check @@ float 0.00001)
      (Printf.sprintf "1D %ld" v)
      (Cxx.NegOneToOne.noise_1d seed v)
      noise
  in
  let () = check 0l and () = check 42l and () = check 666l in
  ()

let () =
  let open Alcotest in
  run "Squirrel noise"
    [ ( "Int32"
      , [ test_case "1D" `Quick int32_1d
        ; test_case "2D" `Quick int32_2d
        ; test_case "3D" `Quick int32_3d
        ; test_case "4D" `Quick int32_4d ] )
    ; ("ZeroToOne", [test_case "1D" `Quick zero_to_one_1d])
    ; ("NegOneToOne", [test_case "1D" `Quick neg_one_to_one_1d]) ]
