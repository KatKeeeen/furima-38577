function calculation (){
  const itemPrice  = document.getElementById("item-price");
  itemPrice.addEventListener("keyup", () => {
    const salesCommission = Math.floor(itemPrice.value * 0.1);
    const salesProfit = Math.floor(itemPrice.value - salesCommission);
    const commissionNum  = document.getElementById("add-tax-price");
    const profitNum  = document.getElementById("profit");
    commissionNum.innerHTML = `${salesCommission}`;
    profitNum.innerHTML = `${salesProfit}`;
  });
};

window.addEventListener('load', calculation);