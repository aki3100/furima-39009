window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
    priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const ProfitDom = document.getElementById("profit");

    // ↓は販売手数料を出すための計算式
    addTaxDom.innerHTML = Math.floor(inputValue * 0.1);
    // ↓は販売利益を出す計算式（販売価格 - 販売手数料をProfitDom.innerHTMLへ代入）
    ProfitDom.innerHTML = inputValue - addTaxDom.innerHTML;
  })
});