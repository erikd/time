-- #hide
module Data.Time.Calendar.Days
(
	-- * Days
	Day(..),addDays,diffDays
) where

import Data.Ix
import Data.Typeable
#ifdef LANGUAGE_DeriveDataTypeable
#ifdef LANGUAGE_Rank2Types
import Data.Data
#endif
#endif

-- | The Modified Julian Day is a standard count of days, with zero being the day 1858-11-17.
newtype Day = ModifiedJulianDay {toModifiedJulianDay :: Integer} deriving (Eq,Ord
#ifdef LANGUAGE_DeriveDataTypeable
#ifdef LANGUAGE_Rank2Types
    ,Data
#endif
#endif
    )

instance Typeable Day where
	typeOf _ = mkTyConApp (mkTyCon "Data.Time.Calendar.Days.Day") []

-- necessary because H98 doesn't have "cunning newtype" derivation
instance Enum Day where
	succ (ModifiedJulianDay a) = ModifiedJulianDay (succ a)
	pred (ModifiedJulianDay a) = ModifiedJulianDay (pred a)
	toEnum = ModifiedJulianDay . toEnum
	fromEnum (ModifiedJulianDay a) = fromEnum a
	enumFrom (ModifiedJulianDay a) = fmap ModifiedJulianDay (enumFrom a)
	enumFromThen (ModifiedJulianDay a) (ModifiedJulianDay b) = fmap ModifiedJulianDay (enumFromThen a b)
	enumFromTo (ModifiedJulianDay a) (ModifiedJulianDay b) = fmap ModifiedJulianDay (enumFromTo a b)
	enumFromThenTo (ModifiedJulianDay a) (ModifiedJulianDay b) (ModifiedJulianDay c) = fmap ModifiedJulianDay (enumFromThenTo a b c)

-- necessary because H98 doesn't have "cunning newtype" derivation
instance Ix Day where
	range (ModifiedJulianDay a,ModifiedJulianDay b) = fmap ModifiedJulianDay (range (a,b))
	index (ModifiedJulianDay a,ModifiedJulianDay b) (ModifiedJulianDay c) = index (a,b) c
	inRange (ModifiedJulianDay a,ModifiedJulianDay b) (ModifiedJulianDay c) = inRange (a,b) c
	rangeSize (ModifiedJulianDay a,ModifiedJulianDay b) = rangeSize (a,b)

addDays :: Integer -> Day -> Day
addDays n (ModifiedJulianDay a) = ModifiedJulianDay (a + n)

diffDays :: Day -> Day -> Integer
diffDays (ModifiedJulianDay a) (ModifiedJulianDay b) = a - b

{-
instance Show Day where
	show (ModifiedJulianDay d) = "MJD " ++ (show d)

-- necessary because H98 doesn't have "cunning newtype" derivation
instance Num Day where
	(ModifiedJulianDay a) + (ModifiedJulianDay b) = ModifiedJulianDay (a + b)
	(ModifiedJulianDay a) - (ModifiedJulianDay b) = ModifiedJulianDay (a - b)
	(ModifiedJulianDay a) * (ModifiedJulianDay b) = ModifiedJulianDay (a * b)
	negate (ModifiedJulianDay a) = ModifiedJulianDay (negate a)
	abs (ModifiedJulianDay a) = ModifiedJulianDay (abs a)
	signum (ModifiedJulianDay a) = ModifiedJulianDay (signum a)
	fromInteger = ModifiedJulianDay

instance Real Day where
	toRational (ModifiedJulianDay a) = toRational a

instance Integral Day where
	toInteger (ModifiedJulianDay a) = toInteger a
	quotRem (ModifiedJulianDay a) (ModifiedJulianDay b) = (ModifiedJulianDay c,ModifiedJulianDay d) where
		(c,d) = quotRem a b
-}
