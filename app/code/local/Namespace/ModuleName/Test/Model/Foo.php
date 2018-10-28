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
     */
    public function exampleTest()
    {
        $this->assertTrue(true);
    }

    public function testItReturnsTheCurrentDate()
    {
        $foo = Mage::getModel('namespace_modulename/foo');
        $today = Carbon::now()->toDateString();
        $this->assertEquals($today, $foo->getCurrentDate());
    }
}
