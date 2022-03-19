const ZuriERC20 = artifacts.require('ZuriERC20');

contract("ZuriERC20", (accounts)=>{
    console.log(accounts);

    before(async ()=>{
        zuriERC20 = await ZuriERC20.deployed()
    })

    it("gives the owner of the token 1M tokens", async () => {
        let balance = await ZuriERC20.balanceOf(accounts[0]);
        //console.log(balance);

        //balance can be hard to read so use this:
        console.log(web3.utils.fromWei(balance), 'ether');

        balance = web3.utils.fromWei(balance, 'ether');
        assert.equal(balance, '1000000', "Balance should be 1M tokens for contract creators")
    })

    it("can transfer tokens between accounts", async () => {
        let amount = web3.utils.toWei('1000', 'ether')
        await ZuriERC20.transfer(accounts[1], amount, { from: accounts[0]})

        let balance = await ZuriERC20.balanceOf(accounts[1])
        balance = web3.utils.fromWei(balance, 'ether');
        assert.equal(balance, '1000', "Balance should be 1k tokens for receiver")
    })


})