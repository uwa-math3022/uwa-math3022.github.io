function renderMaths() {
  
  let macros = {
    
    // Space before an operator (e.g. total differential)
    '\\mathopspace': '\\mathop{}\\!',
    
    // More vertical space for lines containing fractions etc.
    '\\tallspace': '0.8em',
    
    // Asymptotically
    '\\asy': '\\sim',
    
    // Identically equal to
    '\\ideq': '\\equiv',
    
    // Bold vectors
    '\\vec': '\\boldsymbol{\\mathbf{#1}}',
    
    // Delimiters
    '\\delimleft': '\\mathopen{}\\mathclose\\bgroup\\left#1',
    '\\delimright': '\\right#1\\egroup',
    '\\delimwrap': '\\delimleft{#1}{#2}\\delimright{#3}',
    
    // Bracketing
    '\\curlybr': '\\delimwrap{\\{}{#1}{\\}}',
    '\\roundbr': '\\delimwrap{(}{#1}{)}',
    '\\squarebr': '\\delimwrap{[}{#1}{]}',
    
    // Evaluated at
    '\\eval': '\\delimwrap{.}{#1}{\\rvert}',
    
    // Fencing
    '\\abs': '\\delimwrap{\\lvert}{#1}{\\rvert}', /* or, '\\situps' */
    '\\norm': '\\delimwrap{\\lVert}{#1}{\\rVert}',
    
    // Del operator
    '\\del': '\\mathopspace\\vec{\\nabla}',
    
    // Partial differential
    '\\pd': '\\mathopspace\\partial',
    
    // Total differential
    '\\td': '\\mathopspace\\mathrm{d}',
    
    // Cross product
    '\\crossp': '\\boldsymbol\\times',
    
    // Dot product
    '\\dotp': '\\boldsymbol\\cdot',
    
    // Basis vectors
    '\\basisvec': '\\mathopspace\\vec{a}_{#1}',
    
    // Units
    '\\unit': '\\mathopspace\\text{#1}',
    
    // Text quantities
    '\\textq': '\\{\\text{#1}\\}',
    
    // Generic constant
    '\\const': '\\mathrm{const}',
    
    // Natural exponential base
    '\\ee': '\\mathrm{e}',
    
    // Imaginary unit
    '\\ii': '\\mathrm{i}',
    
    // Real and imaginary parts
    '\\Re': '\\mathopspace\\mathrm{Re}',
    '\\Im': '\\mathopspace\\mathrm{Im}',
    
    // Order (Big-O)
    '\\order': '\\mathopspace O',
    
    // Colours
    '\\colr': '\\htmlClass{colour-r}{#1}',
    '\\colg': '\\htmlClass{colour-g}{#1}',
    '\\colb': '\\htmlClass{colour-b}{#1}',
    '\\colv': '\\htmlClass{colour-v}{#1}',
    
    // Epsilon
    '\\eps': '\\varepsilon',
    
  };
  
  let mathsElements = document.getElementsByClassName("js-maths");
  
  for (let i = 0; i < mathsElements.length; i++) {
    let elem = mathsElements[i]
    katex.render(
      elem.textContent,
      elem,
      {
        displayMode: elem.tagName === "DIV",
        macros: macros,
        trust: (context) => context.command === '\\htmlClass',
        throwOnError: false,
      }
    )
  }
  
}
