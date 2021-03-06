module Tests.Writers.Native (tests) where

import Test.Framework
import Tests.Helpers
import Text.Pandoc
import Text.Pandoc.Arbitrary ()
import Test.QuickCheck (mapSize)

p_write_rt :: Pandoc -> Bool
p_write_rt d =
  read (purely (writeNative def{ writerTemplate = Just "" }) d) == d

p_write_blocks_rt :: [Block] -> Bool
p_write_blocks_rt bs =
  read (purely (writeNative def) (Pandoc nullMeta bs)) ==
  bs

tests :: [Test]
tests = [ property "p_write_rt" p_write_rt
        , property "p_write_blocks_rt" $ mapSize
             (\x -> if x > 3 then 3 else x) $ p_write_blocks_rt
        ]
