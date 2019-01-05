<?php

use Carbon\Carbon;

/**
 * @package    Namespace_ModuleName
 * @author     authorName <author@email.net>
 *
 * PHPUnit Class Annotations
 * @group Namespace_ModuleName
 */
class Namespace_ModuleName_Test_Model_Foo extends EcomDev_PHPUnit_Test_Case
{
    /**
     * @test
     *
     * The test checks much more than just the current date: the module Foo imports
     * the Carbon library thanks to the module firegento/psr0autoloader, and the
     * forked testing module MageTestStand installs the dependencies during the
     * build process, so that they are available when the test is run.
     */
    public function it_returns_the_current_date()
    {
        $foo = Mage::getModel('namespace_modulename/foo');
        $today = Carbon::now()->toDateString();
        $this->assertEquals($today, $foo->getCurrentDate());
    }
}
