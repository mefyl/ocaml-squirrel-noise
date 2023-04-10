include Squirrel_noise_intf

module I32 = struct
  include Unsigned.UInt32

  let ( + ) = add

  and ( * ) = mul

  and ( lxor ) = logxor

  and ( lsr ) = shift_right
end

let squirrel_noise_5 ~seed pos =
  let noise1 = I32.of_int32 0xd2a80a3fl
  (* 11010010101010000000101000111111 *)
  and noise2 = I32.of_int32 0xa884f197l
  (* 10101000100001001111000110010111 *)
  and noise3 = I32.of_int32 0x6C736F4Bl
  (* 01101100011100110110111101001011 *)
  and noise4 = I32.of_int32 0xB79F3ABBl
  (* 10110111100111110011101010111011 *)
  and noise5 =
    I32.of_int32 0x1b56c4f5l
    (* 00011011010101101100010011110101 *)
  in
  let open I32 in
  let mangled = (pos * noise1) + seed in
  let mangled = (mangled lxor (mangled lsr 9)) + noise2 in
  let mangled = mangled lxor (mangled lsr 11) * noise3 in
  let mangled = (mangled lxor (mangled lsr 13)) + noise4 in
  let mangled = mangled lxor (mangled lsr 15) * noise5 in
  mangled lxor (mangled lsr 17)

module UInt32 = struct
  type t = I32.t

  let prime1 = I32.of_int32 198491317l

  (* Large prime number with non-boring bits *)

  let prime2 = I32.of_int32 6542989l

  (* Large prime number with distinct and non-boring bits *)

  let prime3 = I32.of_int32 357239l

  (* Large prime number with distinct and non-boring bits *)

  let noise ~seed x = squirrel_noise_5 ~seed:(Unsigned.UInt32.of_int32 seed) x

  let noise_1d ~seed x =
    let x = I32.of_int32 x in
    noise ~seed x

  let noise_2d ~seed x y =
    let x = I32.of_int32 x and y = I32.of_int32 y in
    noise ~seed I32.(x + (prime1 * y))

  let noise_3d ~seed x y z =
    let x = I32.of_int32 x and y = I32.of_int32 y and z = I32.of_int32 z in
    noise ~seed I32.(x + (prime1 * y) + (prime2 * z))

  let noise_4d ~seed x y z t =
    let x = I32.of_int32 x
    and y = I32.of_int32 y
    and z = I32.of_int32 z
    and t = I32.of_int32 t in
    noise ~seed I32.(x + (prime1 * y) + (prime2 * z) + (prime3 * t))
end

module Int32 = struct
  include (UInt32 : S with type t := UInt32.t)

  type t = Int32.t

  let noise_1d ~seed x = noise_1d ~seed x |> I32.to_int32

  let noise_2d ~seed x y = noise_2d ~seed x y |> I32.to_int32

  let noise_3d ~seed x y z = noise_3d ~seed x y z |> I32.to_int32

  let noise_4d ~seed x y z t = noise_4d ~seed x y z t |> I32.to_int32
end

module ZeroToOne = struct
  type t = float

  let ratio = 1.0 /. Stdlib.Int64.to_float 0xFFFFFFFFL

  let project noise =
    let noise = Unsigned.UInt32.to_int64 noise |> Stdlib.Int64.to_float in
    noise *. ratio

  let noise_1d ~seed x = UInt32.noise_1d ~seed x |> project

  let noise_2d ~seed x y = UInt32.noise_2d ~seed x y |> project

  let noise_3d ~seed x y z = UInt32.noise_3d ~seed x y z |> project

  let noise_4d ~seed x y z t = UInt32.noise_4d ~seed x y z t |> project
end

module NegOneToOne = struct
  type t = float

  let ratio = 1.0 /. Stdlib.Int64.to_float 0x7FFFFFFFL

  let project noise =
    let noise = Stdlib.Int32.to_float noise in
    noise *. ratio

  let noise_1d ~seed x = Int32.noise_1d ~seed x |> project

  let noise_2d ~seed x y = Int32.noise_2d ~seed x y |> project

  let noise_3d ~seed x y z = Int32.noise_3d ~seed x y z |> project

  let noise_4d ~seed x y z t = Int32.noise_4d ~seed x y z t |> project
end
