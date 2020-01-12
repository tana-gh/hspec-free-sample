module HspecFreeSample.Spec.AppSpec where

import Control.Monad.State
import HspecFreeSample.App
import HspecFreeSample.Spec.Mock
import Test.Hspec

spec :: Spec
spec =
    describe "askPrint" $
        it "asks and print are called correctly" $ do
            st <- (`execStateT` initialMockState) . runMock $ runApp app
            asksState  st `shouldBe` [asksCalled]
            printState st `shouldBe` [asksCalled]
